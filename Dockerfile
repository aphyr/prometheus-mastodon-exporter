FROM babashka/babashka

COPY prometheus-mastodon-exporter .

ENV METRICS_PORT=10001

ENTRYPOINT ./prometheus-mastodon-exporter --instance $MASTODON_INSTANCE_URI --port $METRICS_PORT
