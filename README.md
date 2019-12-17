# noVNC Display Container
```
```
This image is intended to be used for displaying X11 applications from other containers in a browser. A stand-alone demo as well as a [Version 2](https://docs.docker.com/compose/compose-file/#version-2) composition.

## Image Contents

* [Xvfb](http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) - X11 in a virtual framebuffer
* [x11vnc](http://www.karlrunge.com/x11vnc/) - A VNC server that scrapes the above X11 server
* [noNVC](https://kanaka.github.io/noVNC/) - A HTML5 canvas vnc viewer
* [socat](http://www.dest-unreach.org/socat/) - for use with other containers
* [supervisord](http://supervisord.org) - to keep it all running

## Usage

### Variables

You can specify the following variables:
* `DISPLAY_WIDTH=<width>` (1024)
* `DISPLAY_HEIGHT=<height>` (768)

### Stand-alone Demo
Run:
```bash
$ docker run --rm -it -p 8080:8080 haxwithaxe/novnc
```
Open a browser and see the `xterm` demo at `http://<server>:8080/vnc.html`

### V2 Composition
An example docker-compose.yml is shown below to illustrate how this image can be used to greatly simplify the use of X11 applications in other containers. With just `docker-compose up -d`, your favorite IDE can be accessed via a browser.

Some notable features:
* An `x11` network is defined to link the IDE and novnc containers
* The IDE `DISPLAY` environment variable is set using the novnc container name
* The screen size is adjustable to suit your preferences via environment variables
* The only exposed port is for HTTP browser connections

```
version: '2'
services:

  ide:
    image: psharkey/intellij:latest
    environment:
      - DISPLAY=novnc:0.0
    depends_on:
      - novnc
    networks:
      - x11

  novnc:
    image: theasp/novnc:latest
    environment:
      # Adjust to your screen size
      - DISPLAY_WIDTH=1600
      - DISPLAY_HEIGHT=968
      - RUN_XTERM=no
    ports:
      - "8080:8080"
    networks:
      - x11

networks:
  x11:
```
**If the IDE fails to start simply run `docker-compose restart <container-name>`.**

## On DockerHub / GitHub
___
* DockerHub [haxwithaxe/novnc](https://hub.docker.com/r/haxwithaxe/novnc/)
* GitHub [haxwithaxe/docker-novnc](https://github.com/haxwithaxe/docker-novnc)

# Thanks
___
This is based on theasp/novnc which is based on the alpine container by @psharkey: https://github.com/psharkey/docker/tree/master/novnc, [wine-x11-novnc-docker](https://github.com/solarkennedy/wine-x11-novnc-docker), and [octave-x11-novnc-docker](https://hub.docker.com/r/epflsti/octave-x11-novnc-docker/).
