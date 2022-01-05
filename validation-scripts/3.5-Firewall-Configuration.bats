#!/usr/bin/env bats

@test "3.5.1.1 Ensure Uncomplicated Firewall is installed  (Scored)" {
    [[ $(dpkg -s ufw | grep -i status) || $(dpkg -s nftables | grep -i status) || $(dpkg -s iptables | grep -i status) ]]
}

@test "3.5.1.2 Ensure iptables-persistent is not installed (Scored)" {
    run bash -c "dpkg-query -s iptables-persistent"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'iptables-persistent' is not installed and no information is available"* ]]
}


@test "3.5.1.3  Ensure ufw service is enabled (Scored)" {
    run bash -c "systemctl is-enabled ufw"
    [ "$status" -eq 0 ]
    [ "$output" = "enabled" ]
}

@test "3.5.1.4 Ensure loopback traffic is configured (Scored)" {
    run bash -c "ufw status verbose"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Anywhere on lo"*"ALLOW IN"*"Anywhere"* ]]
    [[ "$output" == *"Anywhere"*"DENY IN"*"127.0.0.0/8"* ]]
   #[[ "$output" == *"Anywhere (v6) on lo"*"ALLOW IN"*"Anywhere (v6)"* ]]
   #[[ "$output" == *"Anywhere (v6)"*"DENY IN"*"::1"* ]]
   # [[ "$output" == *"Anywhere"*"ALLOW OUT"*"Anywhere on lo"* ]]
   # [[ "$output" == *"Anywhere (v6)"*"ALLOW OUT"*"Anywhere (v6) on lo"* ]]
}

@test "3.5.1.5 Ensure outbound connections are configured (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "3.5.1.6 Ensure firewall rules exist for all open ports (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "3.5.1.7 Ensure default deny firewall policy (Scored)" {
    run bash -c "ufw status verbose | grep -i default"
    [ "$status" -eq 0 ]
    [[ "$output" == *"deny (incoming)"* || "$output" == *"reject (incoming)"* ]]
    [[ "$output" == *"deny (outgoing)"* || "$output" == *"reject (outgoing)"* ]]
    [[ "$output" == *"deny (routed)"* \
     || "$output" == *"reject (routed)"* \
     || "$output" == *"disabled (routed)"* ]]
}