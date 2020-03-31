#!/usr/bin/env bash
# Clean up all artifacts created for the demo besides the cluster and the Velero installation itself

velero backup delete --all --confirm

kind delete cluster

say "Done tearing down"
