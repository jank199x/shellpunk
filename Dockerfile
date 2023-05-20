FROM alpine:latest
LABEL maintainer="Jank jank@panichev.xyz"

RUN apk add --update --no-cache openssh doas zsh mandoc man-pages mandoc-apropos docs tmux

RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

RUN adduser -h /home/shellpunk -s /bin/sh -D shellpunk
RUN echo -n 'shellpunk:shellpunk' | chpasswd
RUN echo 'permit nopass :shellpunk' > /etc/doas.d/doas.conf
RUN sed -i -e "s/home\/shellpunk:\/bin\/sh/home\/shellpunk:\/bin\/zsh/" /etc/passwd

EXPOSE 22
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
