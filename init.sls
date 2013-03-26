deb http://ppa.launchpad.net/vbulax/collectd5/ubuntu precise main:
  pkgrepo.managed:
    - dist: precise
    - file: /etc/apt/sources.list.d/collectd.list
    - keyid: 232E4010A519D8D831B81C56C1F5057D013B9839
    - keyserver: keyserver.ubuntu.com

collectd:
  pkg.installed:
    - require:
      - pkgrepo: deb http://ppa.launchpad.net/vbulax/collectd5/ubuntu precise main
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
    {% if 'databases' in grains %}
    - databases: {{ grains['databases'] }}
    {% endif %}
    - require:
      - pkg: collectd

