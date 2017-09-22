
# submod/tensorflow-serving-s2i
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
# MAINTAINER Your Name <your@email.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Tensorflow serving builder" \
      io.k8s.display-name="tensorflow serving builder" \
      io.openshift.expose-services="6006:http" \
      io.openshift.tags="tensorflow"

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
RUN yum install -y tree which \
	&& yum clean all -y



# TODO (optional): Copy the builder files into /opt/app-root
#COPY ./stufff.... /opt/app-root/tensorflow_model_server

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001
COPY ./tensorflow_model_server /opt/app-root/tensorflow_model_server


# EXPOSE 6006

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
