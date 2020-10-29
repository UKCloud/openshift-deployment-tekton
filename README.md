# openshift-deployment-tekton
OpenShift deployment code based on Tekton.


Initial pipeline to deploy OpenShift cluster using IPI approach, requires container image with openshift-installer in the $PATH

Also requires:
configmap with the install-config.yaml required (passed as config workspace)
secret with clouds.yaml (passed as workspace secret)
persistent volume claim to enable deletion of cluster at later date (passed as persistent-data workspace)

To run the pipeline and create a cluster use the following command:

`tkn pipeline start openshift-ipi-deployment -w name=persistent-data,claimName=pipeline-task-cache-pvc -w name=config-map,config=install-config -w name=secret,secret=clouds-yaml -p cluster-operation=create -p installer-image=<container_image>`

To delete a cluster pass the same details but set the cluster-operation parameter to destroy.


DISCLAIMER: This is just the inital setup, and as such is very basic at the moment.
