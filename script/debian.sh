#/bin/dash
LOCK=/tmp/debian

[ -f $LOCK ] && exit 0
touch $LOCK

fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}

# Find a source mirror near you which supports rsync on
# https://launchpad.net/ubuntu/+archivemirrors
# rsync://<iso-country-code>.rsync.archive.ubuntu.com/ubuntu should always work
RSYNCSOURCE=rsync://mirrors.tuna.tsinghua.edu.cn/debian

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mirror/debian

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync -v --ipv4 --timeout=600 --recursive --times --links --hard-links \
  --stats \
  --exclude Packages* --exclude Sources* --exclude Release* --exclude=InRelease --include=i18n/by-hash/** --exclude=i18n/* --exclude ls-lR*
  ${RSYNCSOURCE} ${BASEDIR} || fatal "First stage of sync failed."

rsync --recursive --ipv4 --timeout=600 --times --links --hard-links \
  --stats --delete --delete-after \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Second stage of sync failed."

date -u > ${BASEDIR}/project/trace/$(hostname -f)
rm -f $LOCK
