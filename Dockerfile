FROM ubuntu:22.04

ENV WORKSPACE=/workspace
ENV PATH=${WORKSPACE}/google-cloud-sdk/bin:/root/.local/bin:${PATH}

RUN apt -y update && \
    apt -y install python3 python3-dev python3-pip build-essential curl vim git gnupg2

COPY ./dbt_sandbox_sa_key.json ${WORKSPACE}/dbt-sandbox/dbt_sandbox_sa_key.json

WORKDIR $WORKSPACE

RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-447.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-447.0.0-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh -q && \
    rm google-cloud-cli-447.0.0-linux-x86_64.tar.gz

RUN curl -sSL https://install.python-poetry.org | python3 -

RUN gcloud auth activate-service-account dbt-sandbox@dbt-sandbox-399613.iam.gserviceaccount.com --key-file=${WORKSPACE}/dbt-sandbox/dbt_sandbox_sa_key.json && \
    gcloud config set project dbt-sandbox-399613 && \
    gcloud config set compute/region europe-west10 && \
    gcloud config set compute/zone europe-west10-a && \
    bq ls

COPY elcid_desktop_linux.private ${WORKSPACE}/dbt-sandbox/

RUN mkdir ${HOME}/.ssh && touch ${HOME}/.ssh/config && \
    echo "Host github.com\n\tIdentityFile ${WORKSPACE}/dbt-sandbox/elcid_desktop_linux.private" > ${HOME}/.ssh/config

WORKDIR $WORKSPACE/dbt-sandbox

COPY poetry.lock .
COPY pyproject.toml .

RUN poetry config virtualenvs.in-project true && \
    poetry lock --no-update && \
    poetry install

COPY . .
