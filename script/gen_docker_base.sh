set -e
BASEDIR=$(dirname "$0")
depends=${depends:-/root}
swr=${swr:-swr}
svc=${svc:-jdk:1.8.0-centos7}
pkg=${pkg:-dev}
target=${target}

cp $BASEDIR/../$pkg/basic/Dockerfile.$sufix $BASEDIR/../$pkg/basic/Dockerfile.$sufix.run 
if [ -f $depends/$target ]; then
  mkdir -p /tmp/build
  cp $depends/$target /tmp/build
  docker build /tmp/build -t $swr/$svc -f $BASEDIR/../$pkg/basic/Dockerfile.$sufix.run
  rm -rf /tmp/build
else
  docker build $pkg/basic/ -t $swr/$svc -f $BASEDIR/../$pkg/basic/Dockerfile.$sufix.run
fi
rm $BASEDIR/../$pkg/basic/Dockerfile.$sufix.run -f
docker push $swr/$svc

