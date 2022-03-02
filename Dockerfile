FROM bitnami/minideb:jessie

ENV TG_VERSION="3.4.0" INSTALL_DIR="/home/tigergraph/tigergraph"

RUN useradd -ms /bin/bash tigergraph && \
  sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
  sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn\/debian-security/g' /etc/apt/sources.list && \
  apt-get -qq update && \
  apt-get install -y --no-install-recommends sudo dh-strip-nondeterminism rdfind curl iproute2 net-tools cron ntp locales tar unzip jq uuid-runtime openssh-client openssh-server && \
  mkdir /var/run/sshd && \
  echo 'root:root' | chpasswd && \
  echo 'tigergraph:tigergraph' | chpasswd && \
  sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
  echo "tigergraph    ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
  apt-get clean -y && \
  curl -s -k -L http://192.168.6.137:8000/tigergraph-${TG_VERSION}-offline.tar.gz -o ${INSTALL_DIR}-dev.tar.gz && \
  /usr/sbin/sshd && \
  mkdir -p ${INSTALL_DIR} && \
  chown -R tigergraph:tigergraph ${INSTALL_DIR} && \
  mkdir /var/tmp/tigergraph_logs && \
  cd /home/tigergraph/ && \
  tar xfz tigergraph-dev.tar.gz && \
  rm -f tigergraph-dev.tar.gz && \
  cd ${INSTALL_DIR}-* && \
  sed -i 's/EXIST_SERVICE=true/EXIST_SERVICE=false/g' utils/check_utils && \
  ./install.sh -n || : && \
  su - tigergraph -c "${INSTALL_DIR}/app/${TG_VERSION}/cmd/gadmin stop all -y" || \
  mkdir -p ${INSTALL_DIR}/logs && \
  rm -Rf ${INSTALL_DIR}-* && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/syspre_pkg && \
  rm -f ${INSTALL_DIR}/gium_prod.tar.gz && \
  rm -f ${INSTALL_DIR}/pkg_pool/tigergraph_*.tar.gz && \
  cd /tmp && rm -rf /tmp/tigergraph-* && \
  echo "export VISIBLE=now" >> /etc/profile && \
  echo "export USER=tigergraph" >> /home/tigergraph/.bash_tigergraph && \
  rm -f /home/tigergraph/.gsql_fcgi/RESTPP.socket.1 && \
  mkdir -p /home/tigergraph/.gsql_fcgi && \
  touch /home/tigergraph/.gsql_fcgi/RESTPP.socket.1 && \
  chmod 644 /home/tigergraph/.gsql_fcgi/RESTPP.socket.1 && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/document/examples && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/document/DEMO && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/document/benchmark && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/document/help && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/document/examples && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/document/DEMO && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/document/benchmark && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/document/help && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/bin/go/doc && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/bin/go/src && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/bin/go/test && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/bin/go/blog && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/gui/*.tar.gz && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/*.txt && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/src/er/platform_independent/*.gz && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsql/lib/.tmp_tg_dbs_gsqld.jar && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/share/man && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/share/doc && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/jvm/jdk-11.0.10+9/man && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/jvm/jdk-11.0.10+9/lib/src.zip && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/zk/docs && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/kafka/site-docs/kafka_*.tgz && \
  rm -Rf ${INSTALL_DIR}/data/etcd/member/wal && \
  rm -Rf ${INSTALL_DIR}/data/kafka/Event* && \
  rm -Rf /usr/share/man/* && \
  rm -f /usr/share/info/*.gz && \
  rm -Rf /usr/share/doc && \
  rm -Rf /var/log/*  && \
  rm -Rf ${INSTALL_DIR}/log/*  && \
  cd /tmp/ && \
  rdfind -makesymlinks true /home /usr /bin /lib && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/libtigergraph.so && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_gped && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_restd && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_app_kafkaldr && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_app_fileldr && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_gsed && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/batchdelta && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_admind && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_dictd && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/_pygdict.so && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/gsql_data_generator && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ifmd && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ctrld && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_master && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_slave && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_bootstrap && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/libjemalloc.so.2 && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/statushubcli && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_goblin && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ts3d && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ts3m && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/tg_app_guid && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/lib/tg_${TG_VERSION}_dev/*.a && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/pic_libs/*.a && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gadmin && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gbar && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/cmd/dlv && \
  strip -S -x ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gcollect && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/kafka/plugins/* && \
  rm -Rf /tmp/*  && \
  apt-get autoremove dh-strip-nondeterminism rdfind -y && \
  apt-get clean -y && \
  rm -Rf /var/lib/apt/lists/* && \
  chown -R tigergraph:tigergraph /home/tigergraph

EXPOSE 22
#ENTRYPOINT /usr/sbin/sshd && \
#  ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/kafka_plugins/kafka_plugins_package.sh --target ${INSTALL_DIR}/app/${TG_VERSION}/kafka/plugins/ &&\
#  su - tigergraph bash -c "tail -f /dev/null"
ENTRYPOINT su - tigergraph bash -c "tail -f /dev/null"
