FROM alpine:edge
RUN apk add --no-cache alpine-sdk bison libarchive-tools linux-headers lua5.2 nasm ncurses ninja tzdata wayland-dev

COPY . /oasis
WORKDIR oasis
COPY docker/config.lua .

ENV PATH $PATH:/oasis/out/pkg/texi2mdoc
ENV PAXREAD bsdtar -xf -
RUN git config --global user.name oasis && \
    git config --global user.email oasis && \
    lua5.2 ./setup.lua && \
    ninja out/pkg/texi2mdoc/texi2mdoc && \
    ninja && \
    git -C out/root.git --work-tree=$PWD read-tree -u --prefix=root/ tree

FROM scratch
COPY --from=0 /oasis/root /
COPY docker/etc /etc
RUN /libexec/applyperms -d / && \
    /libexec/applyperms -d /etc && \
    makewhatis /share/man

ENV XDG_RUNTIME_DIR /tmp
CMD ksh -l
