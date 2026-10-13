# shopfleet

Backend services and web frontend for the shopfleet marketplace.

The orders service takes checkout requests and emits order events.
The billing service charges customers when an order is confirmed.
Run everything locally with `docker-compose up`.
Deployed on Kubernetes, see `k8s/`.
