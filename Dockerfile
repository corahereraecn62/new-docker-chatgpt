FROM dorowu/ubuntu-desktop-lxde-vnc:latest


ENV USER=railway
ENV PASSWORD=railway123
ENV RESOLUTION=1280x720
ENV PORT=6080
ENV NOVNC_PORT=${PORT}


# Remove Google Chrome repo to avoid apt errors
RUN rm -f /etc/apt/sources.list.d/google-chrome.list


# Install optional packages
RUN apt-get update && apt-get install -y \
vim \
git \
wget \
curl \
net-tools \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*


# Expose Railway port (dynamic) and VNC port (optional)
EXPOSE ${PORT} 5900


# Start LXDE + VNC + noVNC using Railway port
CMD ["/startup.sh", "-novnc-port", "${NOVNC_PORT}"]
