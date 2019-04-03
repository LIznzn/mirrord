#/bin/dash
LOCK=/tmp/centos

[ -f $LOCK ] && echo "already running" >&2 && exit 0
touch $LOCK

fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}
rsync -avzH --timeout=600 --ipv4 --delay-updates  --delete-delay rsync://mirrors.tuna.tsinghua.edu.cn/centos /mirror/centos
#rsync -avzH --ipv4 --delay-updates  --delete-delay mirrors.kernel.org::centos /data/mirrors/centos


rm -f $LOCK
