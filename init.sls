deb http://ppa.launchpad.net/vbulax/collectd5/ubuntu precise main:
  pkgrepo.managed:
    - dist: precise
    - file: /etc/apt/sources.list.d/collectd.list
    - keyid: 013B9839
    - keyserver: keyserver.ubuntu.com

collectd:
  pkg.installed:
    - require:
      - pkgrepo: deb http://ppa.launchpad.net/vbulax/collectd5/ubuntu precise main
    

# configure collectd to log via graphite
#

