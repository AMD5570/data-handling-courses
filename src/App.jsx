import { useEffect, useMemo, useState } from 'react'
import ForceGraph2D from 'react-force-graph-2d'
import ForceGraph3D from 'react-force-graph-3d'
import SpriteText from 'three-spritetext'
import RITLogo from './assets/rit-logo.png'
import './App.css'

// Colors used for the nodes in the graph
const TYPE_COLORS = {
  Course: '#F76902',
  Topic: '#0288D1',
  Tool: '#388E3C',
}

/**
 * Returns the display label for a node.
 */
function getNodeName(node) {
  return node.name || node.code || 'Unnamed node'
}

/**
 * Gets the string id from a link endpoint.
 */
function getEndpointId(endpoint) {
  return typeof endpoint === 'object' ? endpoint.id : endpoint
}

function App() {
  // core app states
  const [graphData, setGraphData] = useState({ nodes: [], links: [] })
  const [selectedNodeId, setSelectedNodeId] = useState(null)
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [is3D, setIs3D] = useState(false)

  // fetch the entire graph once when the app starts
  useEffect(() => {
    let active = true // prevents state updates if the component unmounts mid request

    async function loadGraph() {
      try {
        const response = await fetch('/api/graph')

        if (!response.ok) {
          throw new Error(`Graph request failed (${response.status})`)
        }
        const data = await response.json()

        if (active) {
          setGraphData(data)
          setError('')
        }
      } catch (requestError) {
        if (active) {
          setError(requestError.message || 'Unable to load graph data.')
        }
      } finally {
        if (active) {
          setLoading(false)
        }
      }
    }

    loadGraph()
    return () => {
      active = false
    }
  }, [])

  // lookup map for getting node objects by an id
  const nodesById = useMemo(
    () => new Map(graphData.nodes.map((node) => [node.id, node])),
    [graphData.nodes],
  )

  const selectedNode = nodesById.get(selectedNodeId)

  // finds all direct neighbors of the current node for the sidebar list
  const connectedNodes = useMemo(() => {
    if (!selectedNodeId) return []

    const neighborIds = new Set()

    for (const link of graphData.links) {
      const sourceId = getEndpointId(link.source)
      const targetId = getEndpointId(link.target)
      
      if (sourceId === selectedNodeId) neighborIds.add(targetId)
      if (targetId === selectedNodeId) neighborIds.add(sourceId)
    }

    return [...neighborIds]
      .map((id) => nodesById.get(id))
      .filter(Boolean)

  }, [graphData.links, nodesById, selectedNodeId])

  // filters and sorts nodes based on the sidebar search input
  const filteredNodes = useMemo(() => {

    const query = search.trim().toLowerCase()

    return graphData.nodes
      .filter((node) => {
        const searchableName = `${node.name || ''} ${node.code || ''}`.toLowerCase()
        return searchableName.includes(query)
      })

      .sort((left, right) => getNodeName(left).localeCompare(getNodeName(right)))

  }, [graphData.nodes, search])

  // Set of nodes that should remain highlighted (when selected + neighbors)
  const highlightedNodeIds = useMemo(() => {
    if (!selectedNodeId) return null

    const ids = new Set([selectedNodeId])

    for (const link of graphData.links) {
      const sourceId = getEndpointId(link.source)
      const targetId = getEndpointId(link.target)
      if (sourceId === selectedNodeId) ids.add(targetId)
      if (targetId === selectedNodeId) ids.add(sourceId)
    }

    return ids

  }, [graphData.links, selectedNodeId])

  /**
   * Renderer for individual graph nodes and their text labels.
   * Dims unrelated nodes when a selection is active and scales text relative to the zoom amount.
   */
  function renderNode(node, context, globalScale) {
    const highlighted = !highlightedNodeIds || highlightedNodeIds.has(node.id)
    const color = TYPE_COLORS[node.type] || '#64748B'
    const radius = node.type === 'Course' ? 7 : 5
    // display node course codes 
    const label = node.type === 'Course' && node.code ? node.code : getNodeName(node)

    context.save()

    // dim unselected nodes
    context.globalAlpha = highlighted ? 1 : 0.15

    // draw node circle
    context.beginPath()
    context.arc(node.x, node.y, radius, 0, 2 * Math.PI)
    context.fillStyle = color
    context.fill()

    // draw a light white border
    context.lineWidth = 1.5 / globalScale
    context.strokeStyle = '#FFFFFF'
    context.stroke()

    // draw text label beneath the node circle
    context.font = `${12 / globalScale}px "Figtree", sans-serif`;
    context.textAlign = 'center'
    context.textBaseline = 'top'
    context.fillStyle = '#263445'
    context.fillText(label, node.x, node.y + radius + 3 / globalScale)
    context.restore()
  }

  function render3DNode(node) {
    const highlighted = !highlightedNodeIds || highlightedNodeIds.has(node.id)
    const label = node.type === 'Course' && node.code ? node.code : getNodeName(node);

    const sprite = new SpriteText(label)
    sprite.color = TYPE_COLORS[node.type] || '#64748B'
    sprite.textHeight = node.type === 'Course' ? 6 : 4
    sprite.material.opacity = highlighted ? 1 : 0.15
    sprite.material.transparent = true
    return sprite
  }

  // helper to make sure an edge is attached to a selected node
  const selectedLink = (link) =>
    !selectedNodeId ||
    getEndpointId(link.source) === selectedNodeId ||
    getEndpointId(link.target) === selectedNodeId

  return (
    <main className="app-shell">

    {/* Left Sidebar: Search, Node Inspector, and Node Legend */}
      <aside className="sidebar">
        <header className="sidebar-header">
          <div className="rit-logo">
            <img src={RITLogo} alt="RIT Logo" />
          </div>
          <div>
            <p className="eyebrow">School of Information</p>
            <h1>Data Handling Courses</h1>
          </div>
        </header>

        {/* Search input and list of matching nodes */}
        <section className="search-section" aria-label="Search graph nodes">
          <label htmlFor="node-search">Find a course, topic, or tool</label>

          <input
            id="node-search"
            type="search"
            placeholder="Search by name or course code"
            value={search}
            onChange={(event) => setSearch(event.target.value)}
          />

          <p className="result-count">
            {filteredNodes.length} {filteredNodes.length === 1 ? 'result' : 'results'}
          </p>

          <ul className="node-results">
            {filteredNodes.map((node) => (
              <li key={node.id}>

                <button
                  type="button"
                  className={`node-result${selectedNodeId === node.id ? ' is-selected' : ''}`}
                  onClick={() => setSelectedNodeId(node.id)}
                >
                  <span
                    className="type-dot"
                    style={{ backgroundColor: TYPE_COLORS[node.type] || '#64748B' }}
                    aria-hidden="true"
                  />
                  <span className="node-result-copy">
                    <span className="node-result-name">{getNodeName(node)}</span>
                    <span className="node-result-type">
                      {node.code && node.name ? `${node.code} · ` : ''}{node.type}
                    </span>
                  </span>

                </button>

              </li>
            ))}
          </ul>
        </section>

        {/* Details showing metadata and clickable neighbors for a selected node */}
        <section className="details-section" aria-live="polite">

          {selectedNode ? (
            <>
              <div className="section-heading">

                <span
                  className="type-dot large"
                  style={{ backgroundColor: TYPE_COLORS[selectedNode.type] || '#64748B' }}
                  aria-hidden="true"
                />

                <div>
                  <p className="eyebrow">Selected {selectedNode.type}</p>
                  <h2>{getNodeName(selectedNode)}</h2>
                </div>

              </div>

              {selectedNode.code && (
                <p className="course-code">Course code: <strong>{selectedNode.code}</strong></p>
              )}

              <h3>Connected nodes <span>{connectedNodes.length}</span></h3>

              {connectedNodes.length > 0 ? (

                <ul className="connected-list">

                  {connectedNodes.map((node) => (

                    <li key={node.id}>
                      <button type="button" onClick={() => setSelectedNodeId(node.id)}>
                        <span
                          className="type-dot"
                          style={{ backgroundColor: TYPE_COLORS[node.type] || '#64748B' }}
                          aria-hidden="true"
                        />

                        <span>{getNodeName(node)}</span>
                        <small>{node.type}</small>
                      </button>
                    </li>

                  ))}

                </ul>

              ) : (
                <p className="muted-copy">No connected nodes found.</p>
              )}
            </>
          ) : (
            <div className="empty-detail">
              <h2>Search for any course, tool, or topic</h2>
              <p>Select any node to view its connections. Click the graph background to clear a selection.</p>
            </div>
          )}

        </section>

        {/* Node Legend */}
        <footer className="legend">
          <p className="eyebrow">Node types</p>
          
          {Object.entries(TYPE_COLORS).map(([type, color]) => (

            <span className="legend-item" key={type}>
              <span className="type-dot" style={{ backgroundColor: color }} aria-hidden="true" />
              {type}
            </span>

          ))}
        </footer>

      </aside>
      
      {/* Right Panel: Interactive ForceGraph2D graph */}
      <section className="graph-panel" aria-label="Course relationship graph">

        <div className="graph-toolbar">
          <div>
            <p className="eyebrow">Neo4j</p>
            <h2>Interactive Graph</h2>
          </div>
          <button className="switchDimensionButton" onClick={() => setIs3D((prev) => !prev)}>
            {is3D ? 'Switch to 2D' : 'Switch to 3D'}
          </button>
        </div>

        {/* Status overlays for loading, errors, or empty results */}
        {loading && <div className="graph-message">Loading courses, tools, and topics...</div>}

        {!loading && error && (
          <div className="graph-message error-message" role="alert">
            <strong>Could not load the graph.</strong>
            <span>{error} Check that the server is up...?</span>
          </div>
        )}

        {!loading && !error && graphData.nodes.length === 0 && (
          <div className="graph-message">No course relationships were found.</div>
        )}

        {/* The main graph showing nodes and their neighbors. Allows for dragging/moving nodes. */}

        {is3D ? (
          <ForceGraph3D
            graphData={graphData}
            backgroundColor="#F4F7FA"
            nodeId="id"
            nodeLabel={(node) => `${getNodeName(node)} (${node.type})`}
            nodeThreeObject={render3DNode}
            nodeThreeObjectExtend={true}
            nodeColor={(node) => {
              const color = TYPE_COLORS[node.type] || '#64748B'
              const opacity = !highlightedNodeIds || highlightedNodeIds.has(node.id) ? 0.6 : 0.15
              const red = Number.parseInt(color.slice(1, 3), 16)
              const green = Number.parseInt(color.slice(3, 5), 16)
              const blue = Number.parseInt(color.slice(5, 7), 16)
              return `rgba(${red}, ${green}, ${blue}, ${opacity})`
            }}
            nodeOpacity={1}
            linkColor={(link) => selectedLink(link) ? '#91A2B5' : 'rgba(145, 162, 181, 0.12)'}
            linkWidth={(link) => selectedLink(link) ? 1.4 : 0.5}
            linkDirectionalArrowLength={4}
            linkDirectionalArrowRelPos={0.97}
            onNodeClick={(node) => setSelectedNodeId(node.id)}
            onBackgroundClick={() => setSelectedNodeId(null)}
            cooldownTicks={90}
            minZoom={10}
            maxZoom={100}
          />
        ) : (
          <ForceGraph2D
            graphData={graphData}
            backgroundColor="#F4F7FA"
            nodeId="id"
            nodeLabel={(node) => `${getNodeName(node)} (${node.type})`}
            nodeCanvasObject={renderNode}
            nodeCanvasObjectMode={() => 'replace'}
            linkColor={(link) => selectedLink(link) ? '#91A2B5' : 'rgba(145, 162, 181, 0.12)'}
            linkWidth={(link) => selectedLink(link) ? 1.4 : 0.7}
            linkDirectionalArrowLength={5}
            linkDirectionalArrowRelPos={0.97}
            linkDirectionalArrowColor={(link) =>
              selectedLink(link) ? '#91A2B5' : 'rgba(145, 162, 181, 0.12)'
            }
            onNodeClick={(node) => setSelectedNodeId(node.id)}
            onBackgroundClick={() => setSelectedNodeId(null)}
            enableNodeDrag
            cooldownTicks={90}
            minZoom={1}
            maxZoom={30}
          />
        )}
      </section>

      <div className="graph-creds">
          <div>
            <p className="eyebrow">Austin deHaan - {new Date().getFullYear()}</p>
          </div>
      </div>

    </main>
  )
}

export default App
