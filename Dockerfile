####################################################
# Calibre ebook manager inside a docker container
#   https://calibre-ebook.com/
#
# https://hub.docker.com/r/gruen/calibre/
# https://github.com/darrengruen/docker-calibre/
#
#
# USAGE
#   docker run -it --rm \
#       -v [/path/to/ebooks]:/books \
#       -v [/path/to/books/to/add]:/downloads \
#       -v /etc/localtime:/etc/localtime
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -e DISPLAY=unix"$DISPLAY" \
#       --name calibre_"$(date +%s) \
#       gruen/calibre
####################################################

# Just a note, this is a huge image using ubuntu:latest
# Probably just as big with most debian derivatives
# Consider moving to alpine
FROM ubuntu
MAINTAINER Darren Green <darren@gruen.site>
RUN apt-get update \
    && apt-get install -y calibre \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get autoremove -y
WORKDIR /books
VOLUME [ "/books" ]
# ENTRYPOINT [ "calibre" ]
CMD [ "calibre", "--with-library", "/books" ]
