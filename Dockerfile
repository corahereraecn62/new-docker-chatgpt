# Use dorowu's Ubuntu Desktop LXDE with VNC + noVNC
FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Set environment variables
ENV USER=railway
ENV PASSWORD=railway123
ENV RESOLUTION=1280x720

# Expose noVNC and VNC ports
EXPOSE 6080 5900

# Optional: install extra packages
RUN apt-get update && apt-get install -y \
    vim \
    git \
    wget \
    curl \
    net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Default command to start VNC + noVNC server
CMD ["/startup.sh"]
