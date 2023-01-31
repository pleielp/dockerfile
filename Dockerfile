FROM node:18-alpine
FROM python:3.11-slim

RUN apk update
RUN apk add -no-cache \
      zip

# pip install
RUN python -m pip install --upgrade pip

RUN pip3 install -r requirements.txt
RUN pip3 install pynecone-io
RUN pc init
RUN pc run
