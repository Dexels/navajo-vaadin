ARG TAG=5.0.0
FROM dexels/dexels-base:$TAG
ADD plugins/ /opt/felix/bundle
ENV NO_BUNDLESYNC=true
ENTRYPOINT ["/opt/felix/startup.sh"]


