FROM bitnami/minideb:jessie

ENV TG_VERSION="3.0.5" INSTALL_DIR="/home/tigergraph/tigergraph"

RUN useradd -ms /bin/bash tigergraph && \
  apt-get -qq update && \
  apt-get install -y --no-install-recommends sudo rdfind curl vim iproute2 net-tools cron ntp locales tar uuid-runtime openssh-client openssh-server && \
  mkdir /var/run/sshd && \
  echo 'root:root' | chpasswd && \
  echo 'tigergraph:tigergraph' | chpasswd && \
  sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
  echo "tigergraph    ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
  apt-get clean -y && \
  curl -s -k -L http://172.16.202.138:8000/tigergraph-${TG_VERSION}-developer.tar.gz -o ${INSTALL_DIR}-dev.tar.gz && \
  /usr/sbin/sshd && \
  mkdir -p ${INSTALL_DIR} && \
  chown -R tigergraph:tigergraph ${INSTALL_DIR} && \
  mkdir /tmp/tigergraph_logs && \
  cd /home/tigergraph/ && \
  tar xfz tigergraph-dev.tar.gz && \
  rm -f tigergraph-dev.tar.gz && \
  cd ${INSTALL_DIR}-* && \
  sed -i 's/EXIST_SERVICE=true/EXIST_SERVICE=false/g' utils/check_utils && \
  ./install.sh -n || : && \
  su - tigergraph -c "${INSTALL_DIR}/app/${TG_VERSION}/cmd/gadmin stop all -y" && \
  mkdir -p ${INSTALL_DIR}/logs && \
  rm -Rf ${INSTALL_DIR}-* && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/syspre_pkg && \
  rm -f ${INSTALL_DIR}/gium_prod.tar.gz && \
  rm -f ${INSTALL_DIR}/pkg_pool/tigergraph_*.tar.gz && \
  rm -Rf /tmp/tigergraph-* && \
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
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/src/er/platform_independent/*.gz && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsql/lib/.tmp_tg_dbs_gsqld.jar && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/*.txt && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/share/man && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/share/doc && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/jvm/java-8-openjdk-amd64-1.8.0.171/jre/man && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/.syspre/usr/lib/jvm/java-8-openjdk-amd64-1.8.0.171/man && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/zk/docs && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/kafka/site-docs/kafka_*.tgz && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/server/node_modules/tar/test/dir-normalization.tar && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/server/node_modules/tar-pack/test/fixtures/packed.tar && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/server/node_modules/tar-pack/test/fixtures/packed.tar.gz && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/server/node_modules/sqlite3/node_modules/tar/test/dir-normalization.tar && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/server/node_modules/sqlite3/node_modules/tar-pack/test/fixtures/packed.tar && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/gui/server/node_modules/sqlite3/node_modules/tar-pack/test/fixtures/packed.tar.gz && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/gui/server/node_modules/sqlite3/node_modules/extsprintf/Makefile.targ && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/server/node_modules/sqlite3/deps/sqlite-autoconf-3150000.tar.gz && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/server/node_modules/extsprintf/Makefile.targ && \
  rm -f ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/node/lib/node_modules/npm/node_modules/request/node_modules/http-signature/node_modules/jsprim/node_modules/extsprintf/Makefile.targ && \
  rm -Rf ${INSTALL_DIR}/data/etcd/member/wal && \
  rm -Rf ${INSTALL_DIR}/data/kafka/Event* && \
  rm -Rf ${INSTALL_DIR}/log/*  && \
  rm -Rf /usr/share/man/* && \
  rm -f /usr/share/info/*.gz && \
  rm -Rf /usr/share/doc && \
  rm -Rf /var/log/*  && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/visualization/ui_package.sh && \
  cd /tmp/ && \
  rdfind -makesymlinks true /home /usr /bin /lib && \
  curl -s -k -L http://172.16.202.138:8000/${TG_VERSION}-dev/pic_libs/librocksdb.a -o librocksdb.a && \
  mv librocksdb.a ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/pic_libs/librocksdb.a && \
  chmod 644 ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/pic_libs/librocksdb.a && \
  curl -s -k -L http://172.16.202.138:8000/${TG_VERSION}-dev/lib/librocksdb.a -o librocksdb.a && \
  mv librocksdb.a ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/lib/tg_${TG_VERSION}_dev/librocksdb.a && \
  chmod 644 ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/lib/tg_${TG_VERSION}_dev/librocksdb.a && \
  curl -s -k -L http://172.16.202.138:8000/${TG_VERSION}-dev/pic_libs/libcryptopp.a -o libcryptopp.a && \
  mv libcryptopp.a ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/pic_libs/libcryptopp.a && \
  chmod 644 ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/include/thirdparty/prebuilt/pic_libs/libcryptopp.a && \
  curl -s -k -L http://172.16.202.138:8000/${TG_VERSION}-dev/lib/libcryptopp.a -o libcryptopp.a && \
  mv libcryptopp.a ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/lib/tg_${TG_VERSION}_dev/libcryptopp.a && \
  chmod 644 ${INSTALL_DIR}/app/${TG_VERSION}/dev/gdk/gsdk/lib/tg_${TG_VERSION}_dev/libcryptopp.a && \
  rm -Rf /tmp/*  && \
  rm -Rf ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui && \
  mkdir -p ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/node/bin/ && \
  echo '#!/bin/sh\necho "NO GUI"' > ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/node/bin/node && \
  chmod +x ${INSTALL_DIR}/app/${TG_VERSION}/bin/gui/node/bin/node && \
  apt-get clean -y && \
  rm -Rf /var/lib/apt/lists/* && \
  chown -R tigergraph:tigergraph /home/tigergraph

EXPOSE 22
ENTRYPOINT /usr/sbin/sshd && \
  su - tigergraph bash -c "/home/tigergraph/tigergraph/app/cmd/gadmin start all" && \
  sleep 1 && \
  su - tigergraph bash -c "tail -f /home/tigergraph/tigergraph/log/admin/ADMIN.INFO"
