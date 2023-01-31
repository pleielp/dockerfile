FROM node:18-alpine
FROM python:3.11-slim

# RUN apk update
# RUN apk add -no-cache \
#       zip
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      zip

# pip install
RUN python -m pip install --upgrade pip

#RUN pip3 install -r requirements.txt
RUN adduser -D pleielp
USER pleielp

RUN pip3 install pynecone-io
RUN pc init
RUN pc run
