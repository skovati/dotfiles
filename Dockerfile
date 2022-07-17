FROM docker.io/alpine:edge

RUN printf "%s\n" "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update &&       \
    apk add --no-cache  \
    build-base \
    ncurses \
    git     \
    doas    \
    curl    \
    stow    \
    neovim  \
    fzf     \
    tmux    \
    zsh     \
    zsh-vcs \
    zsh-autosuggestions     \
    zsh-syntax-highlighting \
    lua-language-server     \
    rust-analyzer           \
    gopls                   \
    pyright

RUN adduser -s /bin/zsh -D -h /home/skovati skovati && \
    adduser skovati wheel && \
    printf "%s\n" "permit nopass :wheel" > /etc/doas.d/doas.conf

USER skovati

WORKDIR /home/skovati

RUN mkdir -p /home/skovati/dev/git \
    /home/skovati/.config \
    /home/skovati/.local/bin \
    /home/skovati/.local/share/zsh \
    /home/skovati/.local/share/nvim

RUN git clone https://github.com/skovati/dotfiles dev/git/dotfiles

RUN stow -d dev/git/dotfiles -t /home/skovati -S tmux nvim zsh bin

RUN nvim --headless -c 'autocmd User PackerComplete quitall'
RUN nvim --headless -c ':TSInstallSync all | qall'

ENV TERM=xterm-256color

ENTRYPOINT ["tmux"]
