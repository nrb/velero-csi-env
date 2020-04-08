# Usage

NOTE:

This repo assumes you're running with the following versions of the dependencies:

 * https://github.com/nrb/external-snapshotter/tree/velero-changes
 * https://github.com/nrb/csi-driver-host-path

These forks contain updates to the YAML files to make sure they build correctly on KinD.

This repo contains a script to spin up a KinD cluster, then installs the CSI [external-snapshotter](https://github.com/kubernetes-csi/external-snapshotter/), [host path driver](https://github.com/kubernetes-csi/csi-driver-host-path), Velero, Contour, and a sample workload.

To install everything, run `install.sh`.

`demo.sh` will run the demo, step by step, pausing for input after each command.

To remove the whole setup, including backups, run `teardown.sh`. Otherwise, run `kind delete cluster` to just delete the cluster.
