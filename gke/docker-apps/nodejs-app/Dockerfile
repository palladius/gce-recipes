# Dockerfile from https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/

FROM node:6.9.2
EXPOSE 8080
COPY server.js .
COPY favicon.ico .
COPY VERSION .
CMD node server.js