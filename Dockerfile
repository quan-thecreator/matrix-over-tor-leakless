FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y build-essential python3-dev libffi-dev python3-pip python-setuptools sqlite3 libssl-dev python3-virtualenv libjpeg-dev libxslt1-dev tor systemctl bash && \
    apt-get install -y lsb-release wget apt-transport-https && \
    wget -O /usr/share/keyrings/matrix-org-archive-keyring.gpg https://packages.matrix.org/debian/matrix-org-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/matrix-org-archive-keyring.gpg] https://packages.matrix.org/debian/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/matrix-org.list && \
    apt update -y && \
    apt install matrix-synapse-py3 -y

COPY torrc /etc/tor/torrc

# Set environment variables for proxy
ENV HTTP_PROXY=localhost:9080

CMD systemctl start tor matrix-synapse
