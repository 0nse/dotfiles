function mountEhdd {
  sudo cryptsetup luksOpen /dev/sdb1 ehdd
  sudo vgchange -ay /dev/ehdd
  sudo mkdir -p /run/media/`whoami`/ehdd
  sleep 1
  sudo mount /dev/ehdd/main /run/media/`whoami`/ehdd
}

function umountEhdd {
  sudo umount /run/media/`whoami`/ehdd
  sudo vgchange -an /dev/ehdd
  sudo cryptsetup luksClose ehdd
}

function mountNexus {
  mkdir ~/nexus && jmtpfs ~/nexus
}

function umountNexus {
  fusermount -u ~/nexus && rm -r ~/nexus
}
