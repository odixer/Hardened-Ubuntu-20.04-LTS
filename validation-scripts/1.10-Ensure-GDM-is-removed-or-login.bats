#!/usr/bin/env bats

@test "1.10 Ensure GDM is removed or login is configured  (Scored)" {
    if dpkg -s gdm; then
        (grep "^banner-message-enable=true" /etc/gdm3/greeter.dconf-defaults)
        (grep "^banner-message-text=" /etc/gdm3/greeter.dconf-defaults)
		(grep "disable-user-list=true" /etc/gdm3/greeter.dconf-defaults)
    fi
}
