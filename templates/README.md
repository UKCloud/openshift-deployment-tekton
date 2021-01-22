# buildconfig_imagestream_templates.yaml

A generic template designed to allow the creation of a BuildConfig and two ImageStreams, one for the base container for the build and one for the output.

## Params

* BUILDCONFIG_NAME - the name to give the BuildConfig
* OUTPUT_IMAGESTREAM_NAME - the name to give the ImageStream that will contain your output image
* OUTPUT_IMAGESTREAM_TAG - the tag given to the output image (this defaults to latest)
* BASE_IMAGESTREAM_NAME - the base image to use with your Dockerfile
* BASE_IMAGESTREAM_TAG - the tag of the input image you want to use (this defaults to latest)
* GIT_SOURCE - the GIT repo you'll pull the Dockerfile from
* GIT_BRANCH - the branch of the repo to use
* CONTEXT_DIR - the directory containing your Dockerfile in the Git repo
* SOURCE_IMAGE_FOR_BASE - the url to access the source image you wish to use as your base (this defaults to the Red Hat RHEL8 UBI minimal image)

Additional variable are available to control the tags used on the input and output ImageStreams. Look in the template file for details, these currently default to latest.

## Usage

To use the template the following is an example that will work with the OpenShift CLI:

```bash
oc process -f  buildconfig_imagestream_templates.yaml -p BUILDCONFIG_NAME=test-buildconfig \
 -p OUTPUT_IMAGESTREAM_NAME=output_imagestream_name \
 -p BASE_IMAGESTREAM_NAME=input_imagestream_name \
 -p GIT_SOURCE=https://github.com/UKCloud/openshift-deployment-tekton.git \
 -p GIT_BRANCH=main \
 -p CONTEXT_DIR=containers/openshift-installer | oc create -f -
```
