{% set collectd_conf = '/etc/collectd/collectd.conf' %}
{% set smartmon = '/srv/collectd/smartmon.sh' %}

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
      - file: {{ collectd_conf }}

smartmontools:
  pkg.installed

{{ smartmon }}:
  file.managed:
    - source: salt://collectd/files{{ smartmon }}
    - mode: 755
    - require:
      - pkg: smartmontools

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
    {% if 'filecount' in grains.get('collectd', {}) %}
    - filecount: {{ grains['collectd']['filecount'] }}
    {% endif %}
    {% if 'loglevel' in grains.get('collectd', {}) %}
    - loglevel: {{ grains['collectd']['loglevel'] }}
    {% endif %}
    {% if 'smartmon_drives' in grains.get('collectd', {}) %}
    - smartmon_drives: {{ grains['collectd']['smartmon_drives'] }}
    {% endif %}
    - require:
      - pkg: collectd
      - file: {{ smartmon }}
