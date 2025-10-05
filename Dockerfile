# Base image with LXDE, VNC, noVNC
FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TINI_SUBREAPER=1
ENV DISPLAY=:1
ENV PASSWORD_FILE=/.vnc/passwd

# Disable Google Chrome repo to avoid GPG error
RUN sed -i '/dl.google.com\/linux\/chrome/d' /etc/apt/sources.list /etc/apt/sources.list.d/* || true

# Update and install Python + Flask
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install flask && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Flask wrapper
COPY run.py /root/run.py

# Expose noVNC port (Railway PORT will override)
EXPOSE 6080

# Start supervisor (already included in base image)
CMD ["supervisord", "-n"]
