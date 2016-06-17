# Calibre Docker Container

Run calibre ebook manager in a docker container

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
