# RIT Data Handling Course Graph

An interactive React graph explorer backed by an Express API and Neo4j. The API reads outgoing relationships from Course nodes and returns unique nodes with their links. The interface supports search, selecting a node and its direct connections, and clearing the selection by clicking the graph background.

## Requirements

- Node.js 20.19+ (required by the Vite version in this project)
- npm
- A reachable Neo4j database containing `Course`, `Topic`, and `Tool` nodes

## Setup

Run these commands from the `data-handling-courses` directory:

```powershell
npm install express neo4j-driver dotenv react-force-graph-2d
Copy-Item .env.example .env
```

Edit `.env` with the connection details for your Neo4j instance:

```dotenv
NEO4J_URI=neo4j+s://your-instance.databases.neo4j.io
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=replace-with-your-password
NEO4J_DATABASE=neo4j
PORT=3001
```

Keep `.env` private and do not commit database credentials.

## Run locally

Open two terminals in the project directory.

Terminal 1 — start the API:

```powershell
npm run server
```

Terminal 2 — start the Vite development server:

```powershell
npm run dev
```

Open the local URL printed by Vite (normally `http://localhost:5173`). Vite proxies `/api` requests to the Express API on port `3001`.

To check the API directly, visit `http://localhost:3001/api/graph`.

## Graph response

`GET /api/graph` runs:

```cypher
MATCH (c:Course)-[r]->(target) RETURN c, r, target
```

It responds with `{ "nodes": [...], "links": [...] }`. Node IDs use Neo4j element IDs, and repeated nodes are included only once.
