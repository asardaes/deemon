FROM python:3.13

USER 0

WORKDIR /

RUN apt-get update \
    && apt-get install -y tini \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt

RUN pip install --no-cache-dir -r requirements.txt \
    && rm -f /requirements.txt \
    && mkdir -m 777 /config /deemix /downloads /import /root/.config \
    && ln -s /config /root/.config/deemon \
    && ln -s /deemix /root/.config/deemix

COPY deemon /app/deemon/
COPY entry.sh /

ENV PYTHONPATH="$PYTHONPATH:/app"

ENTRYPOINT ["tini", "-g", "--"]
CMD ["/entry.sh"]
