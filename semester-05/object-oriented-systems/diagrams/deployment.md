# Deployment

Proposed web deployment versus the local Java prototype.

```mermaid
flowchart LR
 subgraph Local prototype
  A[Customer device JVM or Swing] --> B[OnlineStore and repositories]
  B --> C[(Local XML)]
  B --> D[Simulated payment]
 end
 subgraph Proposed web deployment
  E[Customer browser] -->|HTTPS| F[Web server Nginx]
  F --> G[Application server]
  G --> H[(PostgreSQL server)]
  G -->|Authorized API| I[Payment gateway]
 end
```

The web deployment is a design proposal. The implemented local prototype stores orders in XML and uses a simulated payment gateway.
