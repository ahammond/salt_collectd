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
    

# configure collectd to log via graphite
#

