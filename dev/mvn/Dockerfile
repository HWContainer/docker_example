FROM jdk

COPY --from=loader /apache-maven-3.6.3-bin.tar.gz /apache-maven-3.6.3.bin.tar.gz
ENV MAVEN_HOME=/usr/local/maven/apache-maven-3.6.3
ENV PATH=$PATH:$MAVEN_HOME/bin
RUN tar -zxf apache-maven-3.6.3.bin.tar.gz; mkdir /usr/local/maven; mv apache-maven-3.6.3 /usr/local/maven; \
sed -i '/<mirrors>/a \
<mirror>\n\
    <id>huaweicloud</id>\n\
    <mirrorOf>*,!confluent</mirrorOf>\n\
    <url>https://mirrors.huaweicloud.com/repository/maven/</url>\n\
</mirror>' $MAVEN_HOME/conf/settings.xml; \
sed -i '/<repositories>/a \
<repository>\n\
  <id>confluent</id>\n\
  <name>Repository for confluent builds</name>\n\
  <url>http://packages.confluent.io/maven/</url>\n\
  <layout>default</layout>\n\
  <snapshotPolicy>always</snapshotPolicy>\n\
</repository>' $MAVEN_HOME/conf/settings.xml

