FROM alpine:latest

# update and install base pkgs
RUN apk update && \
    apk add --no-cache openssh curl tmux sudo zsh 

# install dev pkgs
RUN apk add --no-cache neovim nodejs npm go python3 make git grep

# setup skovati user
RUN addgroup -S skovati                                         && \
    adduser -S skovati -G skovati -s /bin/zsh -h /home/skovati  && \
    echo "skovati ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers       && \
    chown -R skovati:skovati /home/skovati

# now act as skovati
USER skovati
WORKDIR /home/skovati

# make dir structure and clone repos
RUN mkdir -p /home/skovati/dev/git                              && \
    cd /home/skovati/dev/git                                    && \
    git clone https://github.com/skovati/dotfiles               && \
    git clone https://github.com/skovati/scripts                && \
    cd ./dotfiles                                               && \
    ./docker_install.sh

# and start up a tmux'ed zsh
ENTRYPOINT "/bin/zsh"
