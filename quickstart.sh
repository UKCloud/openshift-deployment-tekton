# /bin/sh

Echo "User authenticated:"
oc whoami
if [ $? != 0 ]
then
  echo "Not an authenticated user, please authenticate to a cluster before running this script"
  exit
fi

oc project

echo "\nAdding tasks..."
for f in $(find ./tasks -type f -name "*.yml"); do oc apply -f $f; done

echo "\nAdding pipelines..."
for f in $(find ./pipelines -type f -name "*.yml"); do oc apply -f $f; done

echo "\nSetting up Buildconfig and Imagestreams"
oc process -f ./templates/buildconfig_imagestream_templates.yml -p BUILDCONFIG_NAME=openshift-installer-image \
        -p OUTPUT_IMAGESTREAM_NAME=openshift-installer \
        -p BASE_IMAGESTREAM_NAME=ubi-minimal \
        -p GIT_SOURCE=https://github.com/UKCloud/openshift-deployment-tekton.git \
        -p GIT_BRANCH=main \
        -p CONTEXT_DIR=containers | oc create -f -

echo "\nPlease note that if you are using an authenticated registry you will need to add a secret with authentication details to the pipeline user in OpenShift"
