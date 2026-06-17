FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic
RUN apt update && apt install -y \
    sudo \
    wget \
    curl \
    xfce4 \
    xfce4-goodies \
    xrdp \
    dbus-x11 \
    x11-xserver-utils \
    && apt clean

# Install Anydesk
RUN wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add - \
    && echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk.list \
    && apt update \
    && apt install -y anydesk

# Setup user
RUN useradd -m user \
    && echo "ardy28:Dualapan28" | chpasswd \
    && adduser user sudo

# Setup XFCE session
RUN echo "startxfce4" > /home/user/.xsession

# XRDP config
RUN sed -i 's/3389/3389/g' /etc/xrdp/xrdp.ini

EXPOSE 3389

CMD service dbus start && service xrdp start && tail -f /dev/null
