#/bin/bash
LOCK=/tmp/epel

[ -f $LOCK ] && exit 0
touch $LOCK

fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}
SOURCE=rsync://mirrors.tuna.tsinghua.edu.cn/epel
rsync -vazH --timeout=600 --ipv4 --numeric-ids  --delay-updates --delete-delay \
   $SOURCE /mirror/epel

rm -f $LOCK
