FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    xfce4 xfce4-goodies \
    xrdp \
    wget curl sudo \
    dbus-x11 x11-xserver-utils \
    tigervnc-standalone-server \
    novnc websockify \
    net-tools \
    && apt clean

# Install Anydesk
RUN wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add - \
    && echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk.list \
    && apt update \
    && apt install -y anydesk

# Create user
RUN useradd -m user && echo "user:123456" | chpasswd && adduser user sudo

# XFCE session
RUN echo "startxfce4" > /home/user/.xsession && chown user:user /home/user/.xsession

# Setup VNC password
RUN mkdir -p /home/user/.vnc \
    && echo "123456" | vncpasswd -f > /home/user/.vnc/passwd \
    && chmod 600 /home/user/.vnc/passwd \
    && chown -R user:user /home/user/.vnc

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3389 6080

CMD ["/start.sh"]
