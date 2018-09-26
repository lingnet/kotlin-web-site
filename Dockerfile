FROM python:3.6

ARG DEBIAN_FRONTEND=noninteractive

COPY requirements.txt /tmp

RUN apt-get update; \
    apt-get install -y build-essential xorg gdebi ruby xfonts-75dpi xfonts-base; \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb; \
    dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb;

RUN pip install -r /tmp/requirements.txt; \
    gem install kramdown;

EXPOSE 5000
ENTRYPOINT python /src/kotlin-website.py