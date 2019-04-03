#/bin/dash
LOCK=/tmp/cran

[ -f $LOCK ] && echo "already running" >&2 && exit 0
touch $LOCK

fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}
rsync -rtlzv --ipv4 --delete-delay --delay-updates rsync://mirrors.tuna.tsinghua.edu.cn/CRAN /mirror/CRAN > /dev/null

rm -f $LOCK

