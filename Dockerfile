FROM docker.io/alpine:latest

RUN apk update &&       \
    apk add --no-cache  \
    git     \
    zsh     \
    zsh-vcs \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    tmux    \
    fzf     \
    curl    \
    neovim  \
    stow    \
    doas    \
    libuser

RUN adduser -s /bin/zsh -D -h /home/skovati skovati && \
    adduser skovati wheel && \
    echo "permit nopass :wheel" > /etc/doas.d/doas.conf

RUN touch /etc/login.defs && \
    mkdir /etc/default && \
    touch /etc/default/useradd

RUN lchsh skovati /bin/zsh

USER skovati

WORKDIR /home/skovati

RUN mkdir -p /home/skovati/dev/git \
    /home/skovati/.config \
    /home/skovati/.local/bin

RUN git clone https://github.com/skovati/dotfiles dev/git/dotfiles

RUN stow -d dev/git/dotfiles -t /home/skovati -S tmux nvim zsh bin


ENTRYPOINT ["zsh"]
