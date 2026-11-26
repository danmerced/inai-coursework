# Object-oriented design

- Encapsulation: Cart owns its map, returns immutable snapshots; OnlineStore owns the stock and coordinates checkout.
- High cohesion: pricing policy, product storage, payment and order persistence have separate responsibilities. Low coupling: OnlineStore depends on interfaces.
- Strategy: DiscountPolicy is passed to checkout, so changing the pricing rule does not change inventory or persistence.
- Observer: OrderListener receives an event only after persistence.
- Repository: OrderRepository abstracts XML and in-memory storage.
- Facade: OnlineStore exposes the use case without requiring the UI to talk directly to storage.
- Law of Demeter: UI invokes store methods; XML implementation handles node traversal internally.
- Review: stock operations synchronized, price represented by BigDecimal, rejected order never changes stock, XML schema checks structure, DOCTYPE and external resources disabled.
- Complexity: cart add is average O(1); checkout is O(n) in distinct items plus XML file read/write O(m). For many orders use a transactional database instead.
- Concurrency: separate read operations through ExecutorService, synchronized inventory. The prototype serializes checkout within one JVM. It is not multi-process safe and stock is not restored from XML; transactional stock + order + outbox should be used in production.
- Usability: Swing lets a user pick a product and quantity; the CLI prints results. GUI uses in-memory storage for demonstration.
- Use Git feature branches, small commits, code review and issue tracking. Suggested roles: requirements/design, implementation, review; no team work or real production deployment claimed.

DTD describes the tree, XSD additionally constrains quantities and monetary values. The demo uses XSD validation and disallows DOCTYPE to avoid processing external entities.
