FROM node:14 AS builder
ENV WORKDIR /app
RUN mkdir ${WORKDIR}
WORKDIR ${WORKDIR}
COPY . ${WORKDIR}
RUN echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" > ~/.npmrc
RUN yarn
RUN yarn build
RUN rm -rf node_modules
RUN yarn --prod

FROM node:14-slim AS app
ENV WORKDIR /app
ENV DOCKER true
WORKDIR ${WORKDIR}
COPY --from=builder ${WORKDIR} ${WORKDIR}
RUN chmod +x entrypoint.sh
ENTRYPOINT /app/entrypoint.sh
