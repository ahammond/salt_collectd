collectd_ppa:
  pkgrepo.managed:
    - ppa: vbulax/collectd5

collectd:
  pkg.installed:
    - require:
      - pkgrepo: collectd_ppa
  service.running:
    - enable: True
    - require:
      - pkg: collectd
    - watch:
      - file: /etc/collectd/collectd.conf

/etc/collectd/collectd.conf:
  file.managed:
    - source: salt://collectd/files/etc/collectd/collectd.conf.sls
    - template: jinja
    - defaults:
      graphite_host: graphite01
      graphite_port: 2003
      loglevel: notice
    {% if 'databases' in grains %}
    - databases: {{ grains['databases'] }}
    {% endif %}
    {% if grains.get('collectd', {}).get('filecount', {}) %}
    - filecount: grains['collectd']['filecount']
    {$ endif %}
    {% if 'loglevel' in grains.get('collectd', {}) %}
    - loglevel: {{ grains['collectd']['loglevel'] }}
    {% endif %}
    - require:
      - pkg: collectd

