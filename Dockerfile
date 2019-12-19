FROM debian:stable

ENV UID 1000

EXPOSE 8080

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-suggests --no-install-recommends \
      novnc \
      socat \
      supervisor \
      x11vnc \
      xvfb

# Setup demo environment variables
ENV HOME=/home/gui_user \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768

RUN adduser --uid $UID --disabled-password --gecos '' gui_user

# supervisord needs to have write access to its log file 
RUN touch /supervisord.log && chmod a+rw /supervisord.log

COPY . /app

USER gui_user

ENTRYPOINT ["supervisord", "-c", "/app/supervisord.conf"]
