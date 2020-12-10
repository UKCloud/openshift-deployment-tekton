# openshift-deployment-tekton

OpenShift deployment code based on Tekton and OpenShift Pipelines.

DISCLAIMER: This is work in progress, and as such is very basic at the moment.

This repo contains Pipelines, Tasks and other resources for automating the deployment of OpenShift clusters. See the README in each folder for documentation about each module. If no README exists, see the inline comments and descriptions in the yaml files.

The structure of this repo and code follows the conventions from the [Tekton catalog](https://github.com/tektoncd/catalog/blob/master/README.md) which is the basis for the [Tekton Hub (preview)](https://hub-preview.tekton.dev/). These conventions are also followed by [OpenShift Pipelines](https://github.com/openshift/pipelines-catalog).

## Usage

In general, each resource can be created by using `oc apply`. To install directly from this repo, pass the url of the raw file from GitHub to `oc apply -f`.

eg.

```bash
oc apply -f https://raw.githubusercontent.com/UKCloud/openshift-deployment-tekton/main/pipelines/openshift-installer-build/0.1/openshift-installer-build.yml
```

Once created, use the Tekton CLI `tkn` to describe the resource for more information.

```bash
tkn pipeline describe openshift-build-installer-v0-1
```
