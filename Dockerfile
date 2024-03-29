FROM ubuntu:20.04

ENV TG_VERSION=3.6.3 INSTALL_DIR=/home/tigergraph/tigergraph DEBIAN_FRONTEND=noninteractive

RUN useradd -ms /bin/bash tigergraph && \
  sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
  apt-get -qq update && \
  apt-get install -y --no-install-recommends sudo rdfind upx-ucl curl iproute2 net-tools cron ntp locales tar unzip jq uuid-runtime openssh-client openssh-server && \
  echo 'tigergraph:tigergraph' | chpasswd && \
  echo "tigergraph ALL = NOPASSWD: /usr/sbin/sshd" >> /etc/sudoers && \
  sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
  mkdir -p /run/sshd && \
  /usr/sbin/sshd && \
  curl -s -k -L https://dl.tigergraph.com/enterprise-edition/tigergraph-${TG_VERSION}-offline.tar.gz -o ${INSTALL_DIR}-dev.tar.gz && \
  cd /home/tigergraph/ && \
  tar -zxvf tigergraph-dev.tar.gz && \
  cd ${INSTALL_DIR}-3.6.3-offline && \
  sed -i "s@local size=.(awk '/MemTotal/ {print .2}' /proc/meminfo)@local size=8388608@g" utils/os_utils && \
  sed -i "s@legacy_exist=true@legacy_exist=false@g" utils/uninstall_platform.sh && \
  ./install.sh -n || : && \
  su - tigergraph -c "${INSTALL_DIR}/app/${TG_VERSION}/cmd/gadmin stop all -y" && \
  ln -s ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/x86_64-linux-gnu/libbfd-2.26.1-system.so /lib/libbfd-2.26.1-system.so && \
  ln -s ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/bin/strip /usr/bin/strip && \
  rm -rf ${INSTALL_DIR}-* && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/document/examples && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/document/benchmark && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/document/help && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/kafka_plugins/kafka_plugins/* && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/document/examples && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/document/benchmark && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/document/help && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/gui/*.tar.gz && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/src/er/platform_independent/*.gz && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsql/lib/.tmp_tg_dbs_gsqld.jar && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/share/man && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/share/doc && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/jvm/jdk-11.0.10+9/man && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/jvm/jdk-11.0.10+9/lib/src.zip && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/zk/docs && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/kafka/site-docs/kafka_*.tgz && \
  rm -rf ${INSTALL_DIR}/app/${TG_VERSION}/kafka/plugins/* && \
  rm -rf ${INSTALL_DIR}/data/etcd/member/wal && \
  rm -rf ${INSTALL_DIR}/data/kafka/Event* && \
  rm -rf /usr/share/man/* && \
  rm -rf /usr/share/info/*.gz && \
  rm -rf /usr/share/doc && \
  rm -rf /var/log/*  && \
  rm -rf ${INSTALL_DIR}/log/*  && \
  rdfind -makesymlinks true /home /usr /bin /lib && \
  rm -rf results.txt && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/libtigergraph.so && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_gped && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_gped && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_restd && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_restd && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_app_kafkaldr && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_app_kafkaldr && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_app_fileldr && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_app_fileldr && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_gsed && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_dbs_gsed && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/batchdelta && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/batchdelta && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_admind && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_admind && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_dictd && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_dictd && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/_pygdict.so && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/gsql_data_generator && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/gsql_data_generator && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ifmd && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ifmd && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ctrld && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ctrld && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_master && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_master && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_slave && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_slave && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_bootstrap && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/gbar_bootstrap && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/libjemalloc.so.2 && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/statushubcli && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/statushubcli && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_goblin && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_goblin && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ts3d && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ts3d && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ts3m && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/tg_infr_ts3m && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/tg_app_guid && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/tg_app_guid && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/lib/tg_${TG_VERSION}_dev/*.a && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/lib/tg_${TG_VERSION}_dev/libcrypto.so && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/pic_libs/*.a && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/bin/protoc && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/bin/grpc_cpp_plugin && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gadmin && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gadmin && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gbar && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gbar && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/cmd/dlv && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/cmd/dlv && \
  strip -S ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gcollect && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/cmd/gcollect && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/etcd/etcd && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/etcd/etcdctl && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/nginx/sbin/nginx && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/jvm/java-openjdk/lib/server/libjvm.so && \
  upx -v --best ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8 && \
  upx -v --best /usr/bin/perl && \
  rm -rf ${INSTALL_DIR}/tmp/*  && \
  rm -rf /tmp/*  && \
  apt-get autoremove rdfind upx-ucl -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/* && \
  chown -R tigergraph:tigergraph /home/tigergraph

ENTRYPOINT su - tigergraph bash -c "tail -f /dev/null"
