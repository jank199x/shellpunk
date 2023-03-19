FROM alpine:latest
LABEL maintainer="Jank jank@panichev.xyz"

RUN apk add --update --no-cache openssh 
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

RUN adduser -h /home/shellpunk -s /bin/sh -D shellpunk
RUN echo -n 'shellpunk:shellpunk' | chpasswd
RUN apk add doas
RUN echo 'permit shellpunk as root' > /etc/doas.d/doas.conf

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY entrypoint.sh /