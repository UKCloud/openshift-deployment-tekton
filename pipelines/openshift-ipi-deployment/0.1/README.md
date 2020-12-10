# openshift-ipi-deployment Pipeline

Pipeline to deploy an OpenShift cluster using IPI.

## Pre-requisites

* A container image with the openshift-installer app in the $PATH
* A configmap with the install-config.yaml required (passed as config workspace)
* A secret with clouds.yaml (passed as workspace secret)
* A persistent volume claim to enable deletion of cluster at later date (passed as persistent-data workspace)

## Dependencies

This Pipeline depends on ClusterTasks installed by the OpenShift Pipelines operator.

## Params

* CLUSTER_OPERATION - Type of operation to perform, use create for cluster creation or delete for cluster deletion. (default: create)
* INSTALLER_IMAGE - Image containing openshift-install binary.

## Usage

To run the pipeline and create a cluster use the following command:

```bash
tkn pipeline start openshift-ipi-deployment -w name=persistent-data,claimName=pipeline-task-cache-pvc -w name=config-map,config=install-config -w name=secret,secret=clouds-yaml -p cluster-operation=create -p installer-image=<container_image>
```

To delete a cluster pass the same details but set the cluster-operation parameter to destroy.
