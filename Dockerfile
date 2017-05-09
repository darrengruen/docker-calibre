####################################################
# Calibre ebook manager inside a docker container
#   https://calibre-ebook.com/
#
# https://hub.docker.com/r/gruen/calibre/
# https://github.com/darrengruen/docker-calibre/
# USAGE refer to /README.md
####################################################

FROM ubuntu
LABEL maintainer "Darren Green <darren@gruen.site>"
RUN apt-get update \
    && apt-get install -y calibre \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get autoremove -y
WORKDIR /root/books
VOLUME ["/root/books", "/root/Downloads"]
ENTRYPOINT ["calibre"]
CMD ["--with-library", "/root/books", "--no-update-check"]
