#!/usr/bin/env bats

@test "1.5.1 Ensure bootloader password is set (Scored)" {
    (grep '^set superusers' /etc/grub.d/11_superuser)
    (grep "^password" /etc/grub.d/11_superuser)
}

@test "1.5.2 Ensure permissions on bootloader config are configured (Scored)" {
    run bash -c "stat /boot/grub/grub.cfg | grep '^Access: (0400'"
    [ "$status" -eq 0 ]
}

@test "1.5.3 Ensure authentication required for single user mode (Scored)" {
    run bash -c "grep ^root:[*\!]: /etc/shadow"
    [ "$status" -ne 0 ]
}