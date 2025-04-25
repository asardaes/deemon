FROM python:3.13

USER 0

COPY requirements.txt /

RUN apt-get update \
    && apt-get install -y tini \
    && rm -rf /var/lib/apt/lists/*\
    && addgroup --gid 544 deemon \
    && adduser --uid 950 --gid 544 --disabled-password --gecos "" deemon \
    && mkdir /app \
    && chown deemon:deemon /app \
    && mkdir -m 777 /config /deemix /downloads /import \
    && pip install --no-cache-dir -r /requirements.txt \
    && rm -f /requirements.txt

USER deemon:deemon

WORKDIR /app

RUN mkdir /home/deemon/.config \
    && ln -s /config /home/deemon/.config/deemon \
    && ln -s /deemix /home/deemon/.config/deemix

COPY deemon /app/deemon/
COPY entry.sh /

ENV PYTHONPATH="$PYTHONPATH:/app"

ENTRYPOINT ["tini", "-g", "--"]
CMD ["/entry.sh"]
