# Generic Hippo Docker image
FROM centos:7
MAINTAINER swapnil.sonkusare <swapnil.sonkusare@merce.co>

# Set environment variables
ENV PATH /srv/hippo/bin:$PATH
ENV HIPPO_FILE HippoCMS-GoGreen-Enterprise-7.9.4.zip
ENV HIPPO_FOLDER HippoCMS-GoGreen-Enterprise-7.9.4
ENV HIPPO_URL http://download.demo.onehippo.com/7.9.4/HippoCMS-GoGreen-Enterprise-7.9.4.zip

# Create the work directory for Hippo
RUN mkdir -p /srv/hippo

# Add Oracle Java Repositories
RUN CENTOS_FRONTEND=noninteractive yum install -y software-properties-common
RUN CENTOS_FRONTEND=noninteractive add-yum-repository ppa:webupd8team/java
RUN CENTOS_FRONTEND=noninteractive yum update

# Approve license conditions for headless operation
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

# Install packages required to install Hippo CMS
RUN CENTOS_FRONTEND=noninteractive yum install -y oracle-java7-installer
RUN CENTOS_FRONTEND=noninteractive yum install -y oracle-java7-set-default
RUN CENTOS_FRONTEND=noninteractive yum install -y curl
RUN CENTOS_FRONTEND=noninteractive yum install -y dos2unix
RUN CENTOS_FRONTEND=noninteractive yum install -y unzip

# Install Hippo CMS, retrieving the GoGreen demonstration from the $HIPPO_URL and putting it under $HIPPO_FOLDER
RUN curl -L $HIPPO_URL -o $HIPPO_FILE
RUN unzip $HIPPO_FILE
RUN mv /$HIPPO_FOLDER/tomcat/* /srv/hippo
RUN chmod 700 /srv/hippo/* -R

# Replace DOS line breaks on Apache Tomcat scripts, to properly load JAVA_OPTS
RUN dos2unix /srv/hippo/bin/setenv.sh
RUN dos2unix /srv/hippo/bin/catalina.sh

# Expose ports
EXPOSE 8080

# Start Hippo
WORKDIR /srv/hippo/
CMD ["catalina.sh", "run"]

