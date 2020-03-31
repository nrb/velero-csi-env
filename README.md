# Usage

This repo contains a script to spin up a KinD cluster, then installs the CSI external-snapshotter, host path driver, Velero, Contour, and a sample workload.

To install everything, run `install.sh`.

`demo.sh` will run the demo, step by step, pausing for input after each command.

To remove the whole setup, run `teardown.sh`.
