function mountEhdd {
  sudo cryptsetup luksOpen /dev/sdb1 ehdd
  sudo vgchange -ay /dev/ehdd
  sudo mkdir -p /media/ehdd
  sleep 1
  sudo mount /dev/ehdd/main /media/ehdd
}

function umountEhdd {
  sudo umount /media/ehdd
  sudo vgchange -an /dev/ehdd
  sudo cryptsetup luksClose ehdd
}

function mountNexus {
  mkdir ~/nexus && jmtpfs ~/nexus
}

function umountNexus {
  fusermount -u ~/nexus && rm -r ~/nexus
}
