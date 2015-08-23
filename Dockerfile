FROM postgres:latest
MAINTAINER chenmc <maochuan.chen@e-vada.com> 
RUN apt-get update
RUN apt-get install -y wget
RUN wget "http://pgfoundry.org/frs/download.php/3151/pgstatspack_version_2.3.1.tar.gz" -O /tmp/pgstatspack_version_2.3.1.tar.gz
RUN cd /usr/share/; tar xfz /tmp/pgstatspack_version_2.3.1.tar.gz
RUN echo "*/2 * * * * /usr/share/pgstatspack/bin/snapshot.sh" | crontab
RUN echo "0 6 * * * /usr/share/pgstatspack/bin/pgstatspack_report.sh" | crontab
