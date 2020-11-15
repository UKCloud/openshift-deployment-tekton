# openshift-deployment-tekton

OpenShift deployment code based on Tekton.

DISCLAIMER: This is just the inital setup, and as such is very basic at the moment.

## Pipelines

### openshift-ipi-deployment

Initial pipeline to deploy OpenShift cluster using IPI approach, requires container image with openshift-installer in the $PATH

Also requires:

* configmap with the install-config.yaml required (passed as config workspace)
* secret with clouds.yaml (passed as workspace secret)
* persistent volume claim to enable deletion of cluster at later date (passed as persistent-data workspace)

To run the pipeline and create a cluster use the following command:

`tkn pipeline start openshift-ipi-deployment -w name=persistent-data,claimName=pipeline-task-cache-pvc -w name=config-map,config=install-config -w name=secret,secret=clouds-yaml -p cluster-operation=create -p installer-image=<container_image>`

To delete a cluster pass the same details but set the cluster-operation parameter to destroy.

### openshift-installer-build

Pipeline to build images containing the openshift installer. See the spec description field in the pipeline for details.

Run the pipeline with the following command, which will push the image to the internal registry. Note the project name used for the image registry must match the OpenShift project name the pipeline is run in.

`tkn pipeline start openshift-installer-build-v0-1-0 -w name=git-src,volumeClaimTemplateFile=volumeclaimtemplates/vct.yml -p installerRepo=https://github.com/ukcloud/openshift-v4 -p installerDockerfile=upi/vsphere/stage2/4.run-installer/Dockerfile -p installerImage=image-registry.openshift-image-registry.svc:5000/openshift-deployment-tekton/openshift-installer`

To push the installer image to an external registry requiring authentication, add the appropriate credentials as a secret and link the secret to the service account used to execute the pipeline. The default service account is called pipeline, created by the OpenShift Pipelines installation.
