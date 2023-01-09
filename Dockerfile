FROM babashka/babashka

COPY prometheus-mastodon-exporter .

ENTRYPOINT ./prometheus-mastodon-exporter --instance $MASTODON_INSTANCE_URI --port $METRICS_PORT
