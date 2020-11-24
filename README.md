# openshift-deployment-tekton

OpenShift deployment code based on Tekton.

DISCLAIMER: This is just the inital setup, and as such is very basic at the moment.

## BuildConfigs and ImageStreams

### buildconfig_imagestream_templates.yaml

A generic template designed to allow the creation of a BuildConfig and two ImageStreams, one for the base container for the build and one for the output. 

```
BUILDCONFIG_NAME - the name to give the BuildConfig
OUTPUT_IMAGESTREAM_NAME - the name to give the ImageStream that will contain your output image
OUTPUT_IMAGESTREAM_TAG - the tag given to the output image (this defaults to latest)
BASE_IMAGESTREAM_NAME - the base image to use with your Dockerfile
BASE_IMAGESTREAM_TAG - the tag of the input image you want to use (this defaults to latest)
GIT_SOURCE - the GIT repo you'll pull the Dockerfile from
GIT_BRANCH - the branch of the repo to use
CONTEXT_DIR - the directory containing your Dockerfile in the Git repo
SOURCE_IMAGE_FOR_BASE - the url to access the source image you wish to use as your base (this defaults to the Red Hat RHEL8 UBI minimal image)
```

Additional variable are available to control the tags used on the input and output ImageStreams. Look in the template file for details, these currently default to latest.

To use the template the following is an example that will work with the OpenShift CLI:

```
oc process -f  buildconfig_imagestream_templates.yaml -p BUILDCONFIG_NAME=test-buildconfig \
	-p OUTPUT_IMAGESTREAM_NAME=output_imagestream_name \
	-p BASE_IMAGESTREAM_NAME=input_imagestream_name \
	-p GIT_SOURCE=https://github.com/UKCloud/openshift-deployment-tekton.git \
	-p GIT_BRANCH=main \
	-p CONTEXT_DIR=containers | oc create -f -
```

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
