FROM docker.io/alpine:latest

RUN apk update &&       \
    apk add --no-cache  \
    git     \
    zsh     \
    tmux    \
    fzf     \
    curl    \
    neovim  \
    stow    \
    doas

RUN adduser -s /bin/zsh -D skovati && \
    adduser skovati wheel && \
    printf "permit nopass :wheel" > /etc/doas.d/doas.conf

RUN mkdir -p /home/skovati/dev/git \
    /home/skovati/.config \
    /home/skovati/.local/bin

RUN git clone https://github.com/skovati/dotfiles /home/skovati/dev/git/dotfiles

RUN cd /home/skovati/dev/git/dotfiles && \
    stow tmux nvim zsh bin

ENTRYPOINT ["tmux]
