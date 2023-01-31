FROM python:3.18-slim
FROM node:18-alpine

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      zip

# pip install
RUN python -m pip install --upgrade pip

RUN pip3 install -r requirements.txt
RUN pip3 install pynecone-io
RUN pc init
RUN pc run
