CLUSTER_NAME := datahub

cluster:
	kind create cluster --name=$(CLUSTER_NAME)

	kubectl create secret generic postgresql-secrets --from-literal=postgres-password=docker --from-literal=replication-password=docker --from-literal=password=docker

	helm repo add datahub https://helm.datahubproject.io/
	helm install prerequisites datahub/datahub-prerequisites --values values-prerequisites.yaml
	helm install datahub datahub/datahub --values values-datahub.yaml

destroy-cluster:
	kind delete cluster --name=$(CLUSTER_NAME)

install:
	helm install prerequisites datahub/datahub-prerequisites --values values-prerequisites.yaml || echo "Prerequisites already installed"
	helm install datahub datahub/datahub --values values-datahub.yaml || echo "DataHub already installed"

uninstall:
	helm uninstall datahub
	helm uninstall prerequisites

upgrade:
	helm upgrade prerequisites datahub/datahub-prerequisites --values values-prerequisites.yaml
	helm upgrade datahub datahub/datahub --values values-datahub.yaml

k9s:
	kubectx kind-$(CLUSTER_NAME)
	k9s

port-forward:
	kubectl port-forward svc/datahub-datahub-frontend 9002:9002