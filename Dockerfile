FROM python:3.8.0-alpine
LABEL maintainer="hamid.poursepanj"

RUN mkdir -p /var/log/scrapyd  \
    && mkdir -p /var/lib/scrapyd \
    && mkdir -p /var/lib/scrapyd/eggs \
    && mkdir -p /var/lib/scrapyd/dbs \
    && mkdir -p /var/lib/scrapyd/items

RUN addgroup --system scrapy \
    && adduser \
        --system \
        --home /var/lib/scrapyd \
        --gecos "scrapy" \
        --no-create-home \
        --disabled-password scrapy scrapy

COPY requirements.txt .

RUN pip install --upgrade pip \
    && apk add --no-cache --virtual .build-deps gcc musl-dev openssl-dev python3-dev libffi-dev  \
    && apk add --no-cache \
        bash \
        curl \
        supervisor \
        libxslt-dev \
        libxml2-dev \
    && curl -sSL https://github.com/scrapy/scrapy/raw/master/extras/scrapy_bash_completion >> /root/.bashrc \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps \
    && rm -rf /root/.cache

COPY supervisor.conf /etc/supervisor/
COPY scrapyd.conf /etc/scrapyd/
COPY entrypoint.sh /sbin/

EXPOSE 6800

RUN chmod u+x /sbin/entrypoint.sh
RUN chown scrapy:scrapy /var/log/scrapyd \
    /var/lib/scrapyd \
    /var/lib/scrapyd/eggs \
    /var/lib/scrapyd/dbs \
    /var/lib/scrapyd/items

ENTRYPOINT ["./sbin/entrypoint.sh"]