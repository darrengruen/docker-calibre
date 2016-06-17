####################################################
# Calibre ebook manager inside a docker container
# https://hub.docker.com/r/gruen/calibre/
# https://github.com/darrengruen/docker-calibre/
#
#   https://calibre-ebook.com/
#
# USAGE
#   docker run -it --rm \
#       -v [/path/to/ebooks]:/books \
#       -v /etc/localtime:/etc/localtime
#       -v /tmp/.X11-unix:/tmp/.X11.unix \
#       -e DISPLAY=unix$DISPLAY \
#       --name calibre \
#       gruen/calibre
####################################################
FROM ubuntu
MAINTAINER Darren Green <darren@gruen.site>
RUN apt-get update \
    && apt-get install -y calibre \
    && apt-get remove --purge -y $(apt-mark showauto) \
    && rm -rf /var/lib/apt/lists/*
# Once this works we'll add the following all in one command
#     && apt-get autoremove -y \
VOLUME [ "/books" ]
ENTRYPOINT [ "calibre" ]
CMD [ "--with-library", "/books" ]
