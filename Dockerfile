FROM ubuntu

LABEL Darren Green "<darren@gruen.site>"

RUN apt-get update \
    && apt-get install -y calibre \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get autoremove -y
WORKDIR /books
VOLUME [ "/books" ]
# ENTRYPOINT [ "calibre" ]
CMD [ "calibre", "--with-library", "/books" ]
