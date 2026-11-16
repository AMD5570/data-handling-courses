// load environment vars from .env
import 'dotenv/config'
import express from 'express'
import neo4j from 'neo4j-driver'
import process from 'node:process'

const app = express()
const port = Number(process.env.PORT || 3001)

// expected node types to show labels
const recognizedLabels = ['Course', 'Topic', 'Tool'] 

// cypher query to get all courses and their relationships
const graphQuery = 'MATCH (c:Course) - [r] -> (target) RETURN c, r, target'

/**
 * makes a neo4j node record into a object for ForceGraph2D.
 */
function createNode(node) {
  const properties = node.properties
  const type = node.labels.find((label) => recognizedLabels.includes(label)) || node.labels[0]
  
  return {
    id: node.elementId || node.identity.toString(),
    type,
    name: properties.name || properties.code || 'Unnamed node',
    ...(properties.code ? { code: properties.code } : {}),
  }
}

/**
 * GET /api/graph
 * Queries Neo4j for the entire graph and returns nodes and links
 */
app.get('/api/graph', async (_request, response) => {
  let session
  let graph

  try {

    // open a database session
    session = driver.session(
      process.env.NEO4J_DATABASE
        ? { database: process.env.NEO4J_DATABASE }
        : undefined,
    )
    
    const result = await session.run(graphQuery)

    // use a map keyed by node IDs to prevent dups when multiple courses share a tool / topic.
    const nodesById = new Map()

    const links = result.records.map((record) => {
      const course = record.get('c')
      const relationship = record.get('r')
      const target = record.get('target')
      const sourceNode = createNode(course)
      const targetNode = createNode(target)

      nodesById.set(sourceNode.id, sourceNode)
      nodesById.set(targetNode.id, targetNode)

      // return format used in ForceGraph2D
      return {
        source: relationship.startNodeElementId || course.elementId,
        target: relationship.endNodeElementId || target.elementId,
        type: relationship.type,
      }
    })

    graph = { nodes: [...nodesById.values()], links }

  } catch (error) {

    console.error('Failed to retrieve the course graph:', error)
    return response.status(500).json({ error: 'Failed to retrieve graph data.' })

  } finally {

    // closes the session to prevent memory leaks in Neo4j
    if (session) {
      try {
        await session.close()
      } catch (error) {
        console.error('Failed to close the Neo4j session:', error)
      }
    }

  }
  return response.json(graph)
})

// fail on startup if the needed vars for Neo4j are missing
if (!process.env.NEO4J_URI || !process.env.NEO4J_USERNAME || !process.env.NEO4J_PASSWORD) {
  console.error('Set NEO4J_URI, NEO4J_USERNAME, and NEO4J_PASSWORD before starting the API.')
  process.exit(1)
}

// init the Neo4j driver instance
const driver = neo4j.driver(
  process.env.NEO4J_URI,
  neo4j.auth.basic(process.env.NEO4J_USERNAME, process.env.NEO4J_PASSWORD),
)

/**
 * Makes sure the app is connected to Neo4j before starting Express
 */
async function startServer() {
  try {
    await driver.verifyConnectivity()

    app.listen(port, () => {
      console.log(`Graph API listening on http://localhost:${port}`)
    })
  } catch (error) {

    console.error('Unable to connect to Neo4j:', error)
    await driver.close()
    process.exitCode = 1

  }
}

/**
 * Closes the Neo4j driver connection when the server is shut down.
 */
async function shutdown() {
  await driver.close()
  process.exit(0)
}

process.once('SIGINT', shutdown) // signal interrupt
process.once('SIGTERM', shutdown) // signal terminate

// start the server
startServer()
