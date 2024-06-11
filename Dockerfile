    # # set base image (host OS)
    # FROM python:3.8

    # RUN rm /bin/sh && ln -s /bin/bash /bin/sh

    # RUN apt-get -y update
    # RUN apt-get install -y curl nano wget nginx git

    # RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    # RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


    # # # Mongo
    # # RUN ln -s /bin/echo /bin/systemctl
    # # RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
    # # RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    # # RUN apt-get -y update
    # # RUN apt-get install -y mongodb-org

    # # Install Yarn
    # RUN apt-get install -y yarn

    # # Install PIP
    # RUN apt-get install -y python3-pip


    # ENV ENV_TYPE staging
    # ENV MONGO_HOST mongo
    # ENV MONGO_PORT 27017
    # ##########

    # ENV PYTHONPATH=$PYTHONPATH:/src/

    # # copy the dependencies file to the working directory
    # COPY src/requirements.txt .

    # # install dependencies
    # RUN pip install -r requirements.txt

    # Use an official Python runtime as a parent image
    FROM python:3.8

    # Replace default shell with bash
    RUN rm /bin/sh && ln -s /bin/bash /bin/sh

    # Update the package list and install necessary packages
    RUN apt-get -y update && apt-get install -y \
        curl \
        nano \
        wget \
        nginx \
        git \
        && apt-get clean

    # Install Yarn
    RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
        && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
        && apt-get update \
        && apt-get install -y yarn

    # Install pip using the system's package manager
    RUN apt-get install -y python3-pip

    # Set environment variables
    ENV ENV_TYPE staging
    ENV MONGO_HOST host.docker.internal
    ENV MONGO_PORT 27017
    ENV PYTHONPATH=$PYTHONPATH:/src/

    # Copy the dependencies file to the working directory
    COPY src/requirements.txt .

    # Install dependencies
    RUN pip install -r requirements.txt

    # Expose necessary ports
    EXPOSE 8000
