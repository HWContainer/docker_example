BASEDIR=$(dirname "$0")
echo $BASEDIR
swr=${swr:-swr.cn-east-2.myhuaweicloud.com/chinalife_gsy}
nginx=${nginx:-nginx:1.19-alpine}

docker build -t $swr/$nginx - <<END
FROM $nginx
END

docker push $swr/$nginx

