CLUSTER_NAME := datahub

cluster:
    kind create cluster --name=$(CLUSTER_NAME)

    kubectl create secret generic mysql-secrets --from-literal=mysql-root-password=$(CLUSTER_NAME) --from-literal=mysql-password=$(CLUSTER_NAME)
    kubectl create secret generic neo4j-secrets --from-literal=neo4j-password=$(CLUSTER_NAME) --from-literal=NEO4J_AUTH=neo4j/$(CLUSTER_NAME)

    helm repo add datahub https://helm.datahubproject.io/
    helm install prerequisites datahub/datahub-prerequisites
    helm install datahub datahub/datahub

destroy-cluster:
    kind delete cluster --name=$(CLUSTER_NAME)

k9s:
    kubectx kind-$(CLUSTER_NAME)
    k9s