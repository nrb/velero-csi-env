#!/usr/bin/env bash

# Stand up the cluster with Kubernetes v1.18.0 and allow KinD to do Ingress
kind create cluster --image=kindest/node:v1.17.2 --config kind.config.yaml

# Apply the snapshotting CRDs and common controllers
cd $HOME/go/src/github.com/kubernetes-csi/external-snapshotter
kubectl apply -f ./config/crd/
kubectl apply -f deploy/kubernetes/snapshot-controller/
kubectl apply -f deploy/kubernetes/csi-snapshotter/rbac-csi-snapshotter.yaml
kubectl apply -f deploy/kubernetes/csi-snapshotter/setup-csi-snapshotter.yaml

# Create the relevant storage class and volumesnapshotclass
cd $HOME/projects/csi-driver-host-path
./deploy/kubernetes-1.17/deploy-hostpath.sh
kubectl apply -f ./examples/csi-storageclass.yaml
kubectl apply -f ./deploy/kubernetes-1.17/snapshotter/csi-hostpath-snapshotclass.yaml

say "Done installing CSI components"

cd $HOME/projects/csi-demo
# Install Contour so we have an Ingress to get to.
kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
kubectl patch daemonsets -n projectcontour envoy -p '{"spec":{"template":{"spec":{"nodeSelector":{"ingress-ready":"true"},"tolerations":[{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}'

# Install MySQL & Wordpress
kubectl apply -k setup/

say "Done installing Contour and Word press"

source $HOME/bin/gke-vars.sh
v=$HOME/go/src/github.com/vmware-tanzu/velero/_output/bin/darwin/amd64/velero
$v install --provider gcp --plugins velero/velero-plugin-for-gcp:v1.0.1 --bucket $BUCKET --secret-file $CREDS_FILE
kubectl scale deploy/velero -n velero --replicas=0

say "Done installing everything"
