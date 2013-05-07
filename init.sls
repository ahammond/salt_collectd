{% set collectd_conf = '/etc/collectd/collectd.conf' %}
{{ collectd_conf }}:
  file.managed:
    - source: salt://collectd/files{{ collectd_conf }}
    - template: jinja
    - defaults:
      graphite_host: graphite01
      graphite_port: 2003
      loglevel: info
    {% if 'databases' in grains %}
    - databases: {{ grains['databases'] }}
    {% endif %}
    {% if grains.get('collectd', {}).get('filecount', {}) %}
    - filecount: {{ grains['collectd']['filecount'] }}
    {% endif %}
    {% if 'loglevel' in grains.get('collectd', {}) %}
    - loglevel: {{ grains['collectd']['loglevel'] }}
    {% endif %}
