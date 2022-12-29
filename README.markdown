# Prometheus Mastodon Exporter

Fetches statistics from a Mastodon instance's API and exposes them as
Prometheus metrics. You'll need
[Babashka](https://github.com/babashka/babashka) to run this.

## See Also

[andrew-d's exporter](https://github.com/andrew-d/mastodon_exporter) queries
the DB directly and produces post, account, report counts, and report
resolution times.

## Quickstart

You'll need an Oauth access token with admin read access for this to work. Create an app with:

```
curl -X POST \
	-F 'client_name=Prometheus' \
	-F 'redirect_uris=urn:ietf:wg:oauth:2.0:oob' \
	-F 'scopes=read admin:read' \
	-F 'website=https://wherever.your.monitoring.lives' \
	https://your.instance/api/v1/apps
```

Save the client ID and secret. Then in your browser, logged in as an admin, get an auth code by visiting:

```
https://your.instance/oauth/authorize?response_type=code&client_id=YOUR_CLIENT_ID&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=admin:read+read
```

Then copy that code to get an access token:

```
curl -X POST \
  -F 'client_id=YOUR_CLIENT_ID' \
  -F 'client_secret=YOUR_CLIENT_SECRET' \
  -F 'code=YOUR_CODE' \
  -F 'redirect_uri=urn:ietf:wg:oauth:2.0:oob' \
  -F 'grant_type=authorization_code' \
  -F 'scope=read admin:read' \
  https://your.instance/oauth/token
```

Save that auth token somewhere safe. Then run this script with the access token in a `MASTODON_ACCESS_TOKEN` environment variable.

```
MASTODON_ACCESS_TOKEN=YOUR_ACCESS_TOKEN ./prometheus-mastodon-exporter --instance https://your.instance
```

It binds to port 10001 by default; use `--port` to change this.

```
curl http://localhost:10001/metrics
# HELP mastodon_active_users_half_year Users active in the last half year, per nodeinfo.
# TYPE mastodon_active_users_half_year gauge
mastodon_active_users_half_year 192
# HELP mastodon_active_users_month Users active in the last month, per nodeinfo.
# TYPE mastodon_active_users_month gauge
mastodon_active_users_month 192
# HELP mastodon_active_users_yesterday Users active on the previous day.
# TYPE mastodon_active_users_yesterday gauge
mastodon_active_users_yesterday 0
# HELP mastodon_domain_count Number of known peer domains.
# TYPE mastodon_domain_count gauge
mastodon_domain_count 16085
# HELP mastodon_interactions_yesterday Favs, boosts, replies on local statuses during the previous day.
# TYPE mastodon_interactions_yesterday gauge
mastodon_interactions_yesterday 0
# HELP mastodon_local_posts Number of local posts, per nodeinfo
# TYPE mastodon_local_posts gauge
mastodon_local_posts 86101
# HELP mastodon_logins_this_week Number of logins this week.
# TYPE mastodon_logins_this_week gauge
mastodon_logins_this_week 78
# HELP mastodon_logins_last_week Number of logins last week.
# TYPE mastodon_logins_last_week gauge
mastodon_logins_last_week 0
# HELP mastodon_new_users_yesterday Users who signed up the previous day.
# TYPE mastodon_new_users_yesterday gauge
mastodon_new_users_yesterday 6
# HELP mastodon_opened_reports_yesterday Reports opened the previous day.
# TYPE mastodon_opened_reports_yesterday gauge
mastodon_opened_reports_yesterday 1
# HELP mastodon_registrations_this_week Number of registrations this week.
# TYPE mastodon_registrations_this_week gauge
mastodon_registrations_this_week 6
# HELP mastodon_resolved_reports_yesterday Reports resolved the previous day.
# TYPE mastodon_resolved_reports_yesterday gauge
mastodon_resolved_reports_yesterday 1
# HELP mastodon_space_usage_media Bytes used by media files.
# TYPE mastodon_space_usage_media gauge
mastodon_space_usage_media 91551168995
# HELP mastodon_space_usage_postgresql Bytes used by Postgresql.
# TYPE mastodon_space_usage_postgresql gauge
mastodon_space_usage_postgresql 6370169647
# HELP mastodon_space_usage_redis Bytes used by Redis.
# TYPE mastodon_space_usage_redis gauge
mastodon_space_usage_redis 87697152
# HELP mastodon_status_count Number of statuses on the local instance.
# TYPE mastodon_status_count gauge
mastodon_status_count 86128
# HELP mastodon_statuses_this_week Number of statuses posted this week.
# TYPE mastodon_statuses_this_week gauge
mastodon_statuses_this_week 196
# HELP mastodon_statuses_last_week Number of statuses posted last week.
# TYPE mastodon_statuses_last_week gauge
mastodon_statuses_last_week 0
# HELP mastodon_total_users Total users, per nodeinfo
# TYPE mastodon_total_users gauge
mastodon_total_users 1261
# HELP mastodon_user_count Number of users.
# TYPE mastodon_user_count gauge
mastodon_user_count 1261
```
