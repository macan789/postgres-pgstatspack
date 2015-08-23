FROM postgres:latest
MAINTAINER chenmc <maochuan.chen@e-vada.com> 
RUN apt-get update
RUN apt-get install -y wget
RUN wget "http://pgfoundry.org/frs/download.php/3151/pgstatspack_version_2.3.1.tar.gz" -O /tmp/pgstatspack_version_2.3.1.tar.gz
RUN cd /usr/share/; tar xfz /tmp/pgstatspack_version_2.3.1.tar.gz
RUN echo "*/15 * * * * /usr/share/pgstatspack/bin/snapshot.sh 1> /var/log/pgstatspack.log 2>&1" | crontab
RUN echo "2 3 * * * /usr/share/pgstatspack/bin/delete_snapshot.sh 1> /var/log/pgstatspack.log 2>&1" | crontab
RUN echo "0 5 * * * /usr/share/pgstatspack/bin/pgstatspack_report.sh" | crontab
