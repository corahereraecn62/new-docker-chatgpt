# Base image
FROM ubuntu:22.04

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TINI_SUBREAPER=1
ENV HOME=/root
ENV DISPLAY=:1
ENV PASSWORD_FILE=/.password2

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip supervisor wget curl xvfb x11vnc \
    xfce4 xfce4-terminal lxpanel pcmanfm novnc net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install flask

# Create noVNC password file
RUN x11vnc -storepasswd 1234 $PASSWORD_FILE

# Copy supervisor config and run.py
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY run.py /root/run.py

# Expose port (Railway will use PORT env variable)
EXPOSE 6080

# Start supervisor via Tini
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/bin/supervisord", "-n"]
