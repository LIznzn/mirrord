#/bin/dash
LOCK=/tmp/ctan

[ -f $LOCK ] && exit 0
touch $LOCK

fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}

rsync -av --ipv4 --delete rsync://mirrors.tuna.tsinghua.edu.cn/CTAN /mirror/CTAN


rm -f $LOCK
