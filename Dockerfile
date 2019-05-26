FROM debian:buster

RUN apt-get update \
  && apt-get install -y --no-install-recommends -qq \
    calibre=3.39.1+dfsg-3 \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && useradd -m calibre

USER calibre

WORKDIR /home/calibre

VOLUME ["/home/calibre/books", "/home/calibre/Downloads", "/home/calibre/Documents"]

ENTRYPOINT [ "calibre" ]

CMD ["--with-library", "/home/calibre/books"]
