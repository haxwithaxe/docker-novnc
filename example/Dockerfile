FROM haxwithaxe/novnc

USER root

RUN apt-get update && apt-get install -y fluxbox xterm

COPY conf.d/fluxbox.conf conf.d/xterm.conf /app/conf.d/

USER gui_user
