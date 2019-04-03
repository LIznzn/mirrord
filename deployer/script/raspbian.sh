#/bin/bash
LOCK=/tmp/raspbian

[ -f $LOCK ] && exit 0
touch $LOCK

fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}
rsync --timeout=600 --ipv4 --archive --verbose  --delete-delay --delay-updates \
    rsync://mirrors.tuna.tsinghua.edu.cn/raspbian /mirror/raspbian



rm -f $LOCK
