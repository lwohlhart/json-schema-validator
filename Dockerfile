FROM node:alpine

WORKDIR /opt/validator
COPY src .
RUN npm install
ENV PATH="/opt/validator:${PATH}"
WORKDIR /data
COPY ./examples_web/validation.schema.json /data/validation.schema.json
COPY ./examples_web/validation_list.json /data/validation_list.json
ENTRYPOINT [ "json-schema-validator" ]
