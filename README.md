# Calibre Docker Container

Run calibre ebook manager in a docker container

If you like the application, please consider donating on the site. (I get no part of this, I just like to pass the word)

[https://calibre-ebook.com/](https://calibre-ebook.com/)


## Usage

```
docker run -it --rm \
    -v [/path/to/ebooks]:/books \.
    -v /etc/localtime:/etc/localtime \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix"$DISPLAY" \
    --name calibre \
    gruen/calibre
```

### TODO
- Get this working on alpine linux
