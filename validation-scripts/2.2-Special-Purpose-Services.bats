#!/usr/bin/env bats

@test "2.2.1.1 Ensure time synchronization is in use (Scored)" {
    run bash -c "systemctl is-enabled systemd-timesyncd || dpkg -s chrony || dpkg -s ntp"
    [ "$status" -eq 0 ]
}

@test "2.2.1.2 Ensure systemd-timesyncd is disabled (Not Scored)" {
    run bash -c "systemctl status systemd-timesyncd.service | grep Loaded | grep 'masked'"
    [ "$status" -eq 0 ]
}

@test "2.2.1.3 Ensure chrony is not installed(Scored)" {
    run bash -c "dpkg -s chrony"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'chrony' is not installed and no information is available"* ]]
}

@test "2.2.1.4 Ensure ntp is configured (Scored)" {
    run bash -c "grep "^restrict" /etc/ntp.conf"
    [ "$status" -eq 0 ]
    [[ "$output" == *"restrict -4 default "*"kod"* ]]
    [[ "$output" == *"restrict -4 default "*"nomodify"* ]]
    [[ "$output" == *"restrict -4 default "*"notrap"* ]]
    [[ "$output" == *"restrict -4 default "*"nopeer"* ]]
    [[ "$output" == *"restrict -4 default "*"noquery"* ]]
    [[ "$output" == *"restrict -6 default "*"kod"* ]]
    [[ "$output" == *"restrict -6 default "*"nomodify"* ]]
    [[ "$output" == *"restrict -6 default "*"notrap"* ]]
    [[ "$output" == *"restrict -6 default "*"nopeer"* ]]
    [[ "$output" == *"restrict -6 default "*"noquery"* ]]
    # 2.2.1.4 may fail due to "-4" or "-6" not being present in conf file
    run bash -c "grep -E \"^(server|pool)\" /etc/ntp.conf"
    [ "$status" -eq 0 ]
    [[ "$output" == "server "* ]] || [[ "$output" == "pool "* ]]
    run bash -c "grep "RUNASUSER=ntp" /etc/init.d/ntp"
    [ "$status" -eq 0 ]
    [ "$output" = "RUNASUSER=ntp" ]
}

@test "2.2.2 Ensure X Window System is not installed (Scored)" {
    run bash -c "dpkg -l xserver-xorg*"
    [ "$status" -eq 1 ]
    [[ "$output" == *"no packages found matching xserver-xorg*" ]]
}

@test "2.2.3 Ensure Avahi Server is not installed (Scored)" {
    run bash -c "dpkg -s avahi-daemon"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'avahi-daemon' is not installed and no information is available"* ]]
}

@test "2.2.4 Ensure CUPS is not installed (Scored)" {
    run bash -c "dpkg -s cups"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'cups' is not installed and no information is available"* ]]
}

@test "2.2.5 Ensure DHCP Server is not installed (Scored)" {
    run bash -c "dpkg -s isc-dhcp-server"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'isc-dhcp-server' is not installed and no information is available"* ]]
}

@test "2.2.6 Ensure LDAP server is not installed (Scored)" {
    run bash -c "dpkg -s slapd"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'slapd' is not installed and no information is available"* ]]
}

@test "2.2.7 Ensure NFS is not installed (Scored)" {
    run bash -c "dpkg -s nfs-kernel-server"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'nfs-kernel-server' is not installed and no information is available"* ]]
}

@test "2.2.8 Ensure DNS Server is not installed (Scored)" {
    run bash -c "dpkg -s bind9"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'bind9' is not installed and no information is available"* ]]
}

@test "2.2.9 Ensure FTP Server is not installed (Scored)" {
    run bash -c "dpkg -s vsftpd"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'vsftpd' is not installed and no information is available"* ]]
}

@test "2.2.10 Ensure HTTP server is not installed (Scored)" {
    run bash -c "dpkg -s apache2"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'apache2' is not installed and no information is available"* ]]
}

@test "2.2.11 Ensure IMAP server are not installed (Scored)" {
    run bash -c "dpkg -s dovecot-imapd"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'dovecot-imapd' is not installed and no information is available"* ]]
}

@test "2.2.11 Ensure POP3 server are not installed (Scored)" {
    run bash -c "dpkg -s dovecot-pop3d"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'dovecot-pop3d' is not installed and no information is available"* ]]
}

@test "2.2.12 Ensure Samba is not installed (Scored)" {
    run bash -c "dpkg -s samba"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'samba' is not installed and no information is available"* ]]
}

@test "2.2.13  Ensure HTTP Proxy Server is not installed (Scored)" {
    run bash -c "dpkg -s squid"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'squid' is not installed and no information is available"* ]]
}

@test "2.2.14  Ensure SNMP Server is not installed (Scored)" {
    run bash -c "dpkg -s snmpd"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'snmpd' is not installed and no information is available"* ]]
}

@test "2.2.15 Ensure mail transfer agent is configured for local-only mode (Scored)" {
     skip "This audit has to be done manually"
  #  run bash -c "ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|::1):25\s'"
  #  if [ "$status" -eq 0 ]; then
  #      [[ "$output" == "" ]]
  #  fi
}

@test "2.2.16 Ensure rsync service is not installed (Scored)" {
    run bash -c "dpkg -s rsync"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'rsync' is not installed and no information is available"* ]]
}

@test "2.2.17 Ensure NIS Server is not installed (Scored)" {
    run bash -c "dpkg -s nis"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'nis' is not installed and no information is available"* ]]
}