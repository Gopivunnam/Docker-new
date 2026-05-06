ARG BASE_IMAGE=nginx
ARG TAG=latest
FROM ${BASE_IMAGE}:${TAG}
LABEL maintainer="gopivunnam" email="vunnamgopi2504@gmail.com" owner="dockertopic"
ENV AWS_ACCESS_KEY_ID='DUMMYACCESSKEYID'
ENV AWS_SECRET_KEY='DUMMYSECRETKEY'
RUN apt update && apt install -y awscli \
  && apt install -y  unzip net-tools jq nginx iputils-ping \
  && mkdir /etc/demo 
COPY index.html  /var/www/html/index.html
COPY style.css   /Var/www/html/style.css
COPY Error.html  /Var/www/html/Error.html

EXPOSE 80/tcp
CMD [ "/bin/ping", "-c 10", "www.google.com" ]