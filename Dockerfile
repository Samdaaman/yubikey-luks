FROM ubuntu

# Patch for installing tsdata (dependent of devscripts with docker) https://serverfault.com/a/1016972
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update -y && apt-get install -y build-essential devscripts dh-exec

WORKDIR /src

COPY hook initramfs-suspend key-script Makefile README.md ykluks.cfg yubikey-luks-enroll yubikey-luks-enroll.1 yubikey-luks-open yubikey-luks-suspend yubikey-luks-suspend.service ./
COPY debian ./debian

RUN make builddeb NO_SIGN=1

ENTRYPOINT [ "bash" ]