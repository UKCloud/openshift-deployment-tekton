# openshift-installer-build Pipeline

Pipeline to build images containing the openshift installer.

Run the pipeline with the following command, which will push the image to the internal registry. Note the project name used for the image registry must match the OpenShift project name the pipeline is run in.

`tkn pipeline start openshift-installer-build-v0-1-0 -w name=git-src,volumeClaimTemplateFile=volumeclaimtemplates/vct.yml -p installerRepo=https://github.com/ukcloud/openshift-v4 -p installerDockerfile=upi/vsphere/stage2/4.run-installer/Dockerfile -p installerImage=image-registry.openshift-image-registry.svc:5000/openshift-deployment-tekton/openshift-installer`

To push the installer image to an external registry requiring authentication, add the appropriate credentials as a secret and link the secret to the service account used to execute the pipeline. The default service account is called pipeline, created by the OpenShift Pipelines installation.
