# Usage

This repo contains a script to spin up a KinD cluster, then installs the CSI [external-snapshotter](https://github.com/kubernetes-csi/external-snapshotter/), [host path driver](https://github.com/kubernetes-csi/csi-driver-host-path), Velero, Contour, and a sample workload.

To install everything, run `install.sh`.

`demo.sh` will run the demo, step by step, pausing for input after each command.

To remove the whole setup, run `teardown.sh`.

Known issues:

 * The Wordpress pod gets stuck creating for some reason.
