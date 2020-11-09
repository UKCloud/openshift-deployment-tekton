FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

RUN microdnf install wget tar gzip ; microdnf clean all
WORKDIR /tmp
RUN wget -np https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$release/release.txt ;\
    wget -np https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$release/openshift-install-linux.tar.gz ;\
    tar -xvzf /tmp/openshift-install-linux.tar.gz -C /usr/local/bin ;
# Volume mount needs to be for /tmp/workingdir to wherever config.json/secrets.json is
WORKDIR /tmp/workingdir
ENTRYPOINT /bin/sh
