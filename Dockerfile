FROM node:18-alpine
FROM python:3.11-slim

# RUN apk update
# RUN apk add -no-cache \
#       zip
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      zip
# RUN apt-get install -y --no-install-recommends \
#       python3-virtualenv
      
RUN groupadd --gid 1000 python \
    && useradd --uid 1000 --gid python --shell /bin/bash --create-home python
RUN touch ~/.bashrc && chmod +x ~/.bashrc
SHELL ["/bin/bash", "-c"] 

# RUN virutual env
# RUN source env/bin/activate

# pip install
RUN python -m pip install --upgrade pip

#RUN pip3 install -r requirements.txt

# RUN adduser --disabled-password pleielp
# USER pleielp

# build
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN pip3 install pynecone-io

# prepare start
COPY ./ ./
RUN chown -Rf python:python /app
USER python

RUN pc init
RUN pc run
