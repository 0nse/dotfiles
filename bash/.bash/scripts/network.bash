# Kill any currently running DHCP daemon, wpa_supplicant service and
# turn off WiFi if a connection via Ethernet can be established.
function connectViaEthernet {
  sudo ip link set enp2s0 up
  sudo pkill dhcpcd
  sudo systemctl stop wpa_supplicant@wlp3s0b1.service
  sudo dhcpcd enp2s0
  if [[ $? == 0 ]]; then
    sudo rfkill block 0 # block WiFI
    sudo rfkill block 1 # block Bluetooth
  fi
}

# Kill any currently running DHCP daemon, activate WiFi and
# wpa_supplicant.
# TODO: we do not necessarily know what id belongs to WiFI. Thus, we would have to make the rfkill more dynamic
function connectViaWiFi {
  sudo ip link set wlp3s0b1 up
  sudo pkill dhcpcd
  sudo rfkill unblock 0 # activate WiFi
  sudo systemctl start wpa_supplicant@wlp3s0b1.service
  wait 1
  sudo dhcpcd wlp3s0b1
}
