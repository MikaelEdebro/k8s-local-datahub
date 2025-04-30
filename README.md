# k8s-local-datahub

This repo lets you spin up a local Kubernetes cluster with DataHub. This can be used for testing out DataHub locally before you add it to your real cluster.

This particular configuration is using Postgres as a database.

## Prerequisites

Make sure you have these tools installed:

- Kind
- Helm
- kubectl
- kubectx
- make
- k9s (optional)

## Getting started

Make sure you have postgres running locally. I'm using Docker to spin it up.

Then just run `make cluster`.
It will take a while to get all resources up and running.

## Port forward

Run `make port-forward` to access the frontend UI. It will be available on http://localhost:9002 (username/password: datahub)
