# postgres-pgstatspack
pgstatspack把每次采集的snap信息存在数据库里，然后可以对多个snap信息进行比较生成文本的性能报告。

#1.镜像构建及容器创建
--父镜像下载
>docker pull postgres:latest
#（2）镜像构建
docker build -t macan789/postgres-pgstatspack:v1.1 .
#（3）容器创建
docker run --name=postgres-pgstatspack -d -p 15432:5432 -e POSTGRES_PASSWORD=888888 macan789/postgres-pgstatspack:v1.1
#（4）进入容器
docker exec -it <容器id> /bin/bash

#2.监控工具pgstatspack
#（1）请使用用户
su postgres
#（2）安装目录
/usr/share/pgstatspack
#（3）如何监控
#
$ cd /usr/share/pgstatspack
#
$ su postgres
#
$ ./install_pgstats.sh       #安装pgstats （如果默认数据库名postgres无法监控，可以另外创建一个数据库，如testdb，即可开始创建快照并生成报告）
#
$ ./bin/snapshot.sh          #创建snapshot，间隔执行（可通过crontab定时）
#
$ ./bin/pgstatspack_report.sh    #生成报告
#
$ ./bin/delete_snapshot.sh      #删除snapshot

#3.默认定时器
#
/usr/bin/crontab -l
#
*/2 * * * * /usr/share/pgstatspack/bin/snapshot.sh
#
0 6 * * * /usr/share/pgstatspack/bin/pgstatspack_report.sh



