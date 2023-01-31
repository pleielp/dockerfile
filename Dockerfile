FROM python:3.11-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      zip
RUN apt-get install -y --no-install-recommends \
      unzip
RUN apt-get install -y --no-install-recommends \
      curl
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
      apt-get install -y nodejs
RUN npm i -g next
RUN apt-get install -y --no-install-recommends \
      nano
      
RUN groupadd --gid 1000 python \
    && useradd --uid 1000 --gid python --shell /bin/bash --create-home python
RUN touch ~/.bashrc && chmod +x ~/.bashrc
SHELL ["/bin/bash", "-c"] 

# pip install
RUN python -m pip install --upgrade pip

# build
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN pip3 install pynecone-io

# prepare start
# COPY ./ ./
RUN chown -Rf python:python /app
USER python

RUN pc init
