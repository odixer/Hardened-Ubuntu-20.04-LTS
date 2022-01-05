#!/usr/bin/env bats

@test "3.1.1 Disable IPv6 (Not Scored)" {
    run bash -c "grep \"^\s*linux\" /boot/grub/grub.cfg | grep -v \"ipv6.disable=1\""
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}

@test "3.1.2 Ensure wireless interfaces are disabled (Scored)" {
    run bash -c "nmcli radio all"
    if [ "$status" -eq 0 ]; then
        skip "This audit has to be done manually"
    fi
}