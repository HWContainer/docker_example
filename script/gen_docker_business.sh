BASEDIR=$(dirname "$0")
swr=${swr:-swr.cn-east-2.myhuaweicloud.com/chinalife_gsy}
jdk=${jdk:-openjdk:14-centos7}
loader=${loader}
imagevideo=${imagevideo:-imagevideo:1.0.0}
nginx=${nginx:-1.19-alpine}
pre=${pre:-cm-}
pkg=${pkg:-dev}
svc=${svc:-all}
tag=${tag:-1.0.0}
target=${target}
for i in $(ls $BASEDIR/../$pkg); do
  if [[ basic != $i && $svc == $i ]] ; then
    echo build $i
    if [[ $target == $svc ]]; then
       target=$BASEDIR/../$pkg/$i/
    fi
    cp $BASEDIR/../$pkg/$i/Dockerfile $BASEDIR/../$pkg/$i/Dockerfile.run
    sed -i "s@FROM nginx@FROM $swr/$nginx@g" $BASEDIR/../$pkg/$i/Dockerfile.run
    sed -i "s@FROM jdk@FROM $swr/$jdk@g" $BASEDIR/../$pkg/$i/Dockerfile.run
    sed -i "s@loader@$swr/$loader@g" $BASEDIR/../$pkg/$i/Dockerfile.run
    docker build -t $swr/$pre$i:$tag -f $BASEDIR/../$pkg/$i/Dockerfile.run $target
    rm $BASEDIR/../$pkg/$i/Dockerfile.run
    # docker push $swr/$pre$i:$tag
  fi
done
