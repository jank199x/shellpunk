FROM archlinux:latest
LABEL maintainer="Jank jank@panichev.xyz"

# eh
RUN systemd-machine-id-setup

RUN pacman -Syu --noconfirm
RUN pacman -Syy --noconfirm openssh opendoas zsh tmux python python-pip

RUN systemctl enable sshd
# ehh
RUN sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

RUN useradd -m -d /home/shellpunk -s /bin/zsh -G wheel shellpunk
RUN echo -n 'shellpunk:shellpunk' | chpasswd
RUN echo 'permit nopass :wheel as root' > /etc/doas.conf

EXPOSE 22
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
