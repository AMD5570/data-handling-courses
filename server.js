import 'dotenv/config'
import express from 'express'
import neo4j from 'neo4j-driver'
import process from 'node:process'

const app = express()
const port = Number(process.env.PORT || 3001)
const recognizedLabels = ['Course', 'Topic', 'Tool']
const graphQuery = 'MATCH (c:Course) - [r] -> (target) RETURN c, r, target'

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

app.get('/api/graph', async (_request, response) => {
  let session
  let graph

  try {

    session = driver.session(
      process.env.NEO4J_DATABASE
        ? { database: process.env.NEO4J_DATABASE }
        : undefined,
    )
    
    const result = await session.run(graphQuery)
    const nodesById = new Map()

    const links = result.records.map((record) => {
      const course = record.get('c')
      const relationship = record.get('r')
      const target = record.get('target')
      const sourceNode = createNode(course)
      const targetNode = createNode(target)

      nodesById.set(sourceNode.id, sourceNode)
      nodesById.set(targetNode.id, targetNode)

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

if (!process.env.NEO4J_URI || !process.env.NEO4J_USERNAME || !process.env.NEO4J_PASSWORD) {
  console.error('Set NEO4J_URI, NEO4J_USERNAME, and NEO4J_PASSWORD before starting the API.')
  process.exit(1)
}

const driver = neo4j.driver(
  process.env.NEO4J_URI,
  neo4j.auth.basic(process.env.NEO4J_USERNAME, process.env.NEO4J_PASSWORD),
)

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

async function shutdown() {
  await driver.close()
  process.exit(0)
}

process.once('SIGINT', shutdown)
process.once('SIGTERM', shutdown)

startServer()
