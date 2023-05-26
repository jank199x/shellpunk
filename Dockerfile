FROM archlinux:latest
LABEL maintainer="Jank jank@panichev.xyz"

# eh
RUN systemd-machine-id-setup

RUN pacman -Syy --noconfirm openssh sudo zsh tmux python python-pip

RUN systemctl enable sshd
# ehh
RUN sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

RUN useradd -m -d /home/shellpunk -s /bin/zsh -G wheel shellpunk
RUN echo -n 'shellpunk:shellpunk' | chpasswd
RUN echo 'shellpunk ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99-shellpunk

EXPOSE 22
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
