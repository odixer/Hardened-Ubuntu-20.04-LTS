#!/usr/bin/env bats

@test "1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Scored)" {
    run bash -c "modprobe -n -v cramfs | grep -v mtd"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep cramfs"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.1.2 Ensure mounting of freevxfs filesystems is disabled (Scored)" {
    run bash -c "modprobe -n -v freevxfs"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep freevxfs"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.1.3 Ensure mounting of jffs2 filesystems is disabled (Scored)" {
    run bash -c "modprobe -n -v jffs2 | grep -v mtd"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep jffs2"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.1.4 Ensure mounting of hfs filesystems is disabled (Scored)" {
    run bash -c "modprobe -n -v hfs"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep hfs"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.1.5 Ensure mounting of hfsplus filesystems is disabled (Scored)" {
    run bash -c "modprobe -n -v hfsplus"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep hfsplus"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.1.6 Ensure mounting of udf filesystems is disabled (Scored)" {
    run bash -c "modprobe -n -v udf | grep -v crc-itu-t"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep udf"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.1.7 Ensure mounting of FAT filesystems is limited (Not Scored)" {
    if [ ! -d /sys/firmware/efi ]; then
        echo '# Info: UEFI is not utilized on this machine' >&3
        run bash -c "modprobe --showconfig | grep vfat"
        [ "$status" -eq 0 ]
        [ "$output" = "install vfat /bin/true" ]
        run bash -c "lsmod | grep vfat"
        [ "$status" -eq 1 ]
        [ "$output" = "" ]
    else
        echo '# Info: UEFI is utilized on this machine' >&3
        skip "This audit has to be done manually"
    fi
}

@test "1.1.2 Ensure /tmp is configured (Scored)" {
    run bash -c "mount | grep -E '\s/tmp\s'"
    [ "$status" -eq 0 ]
    [[ "$output" = *" on /tmp "* ]]
    local FSTAB=$(grep -E '\s/tmp\s' /etc/fstab | grep -E -v '^\s*#')
    local TMPMOUNT=$(systemctl is-enabled tmp.mount)
    [[ "$FSTAB" != "" ]] || [ "$TMPMOUNT" = "enabled" ]
}


@test "1.1.3 Ensure nodev option set on /tmp partition (Scored)" {
    run bash -c "mount | grep -E '\s/tmp\s' | grep -v nodev"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.4 Ensure nosuid option set on /tmp partition (Scored)" {
    run bash -c "mount | grep -E '\s/tmp\s' | grep -v nosuid"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.5 Ensure noexec option set on /tmp partition (Scored)" {
    run bash -c "mount | grep -E '\s/tmp\s' | grep -v noexec"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.6 Ensure /dev/shm is configured  (Scored)" {
    run bash -c "mount | grep -E '\s/dev/shm\s'"
    [ "$status" -eq 0 ]
    [[ "$output" = *"/dev/shm"* ]]
}

@test "1.1.7 Ensure nodev option set on /dev/shm partition (Scored)" {
    run bash -c "mount | grep -E '\s/dev/shm\s' | grep -v nodev"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.8 Ensure nosuid option set on /dev/shm partition (Scored)" {
    run bash -c "mount | grep -E '\s/dev/shm\s' | grep -v nosuid"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.9 Ensure noexec option set on /dev/shm partition (Scored)" {
    run bash -c "mount | grep -E '\s/dev/shm\s' | grep -v noexec"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.10 Ensure separate partition exists for /var (Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.11 Ensure separate partition exists for /var/tmp (Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.12 Ensure nodev option set on /var/tmp partition (Scored)" {
    run bash -c "mount | grep -E '\s/var/tmp\s' | grep -v nodev"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.13 Ensure nosuid option set on /var/tmp partition (Scored)" {
    run bash -c "mount | grep -E '\s/var/tmp\s' | grep -v nosuid"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.14 Ensure noexec option set on /var/tmp partition (Scored)" {
    run bash -c "mount | grep -E '\s/var/tmp\s' | grep -v noexec"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.15 Ensure separate partition exists for /var/log (Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.16 Ensure separate partition exists for /var/log/audit (Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.17 Ensure separate partition exists for /home (Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.18 Ensure nodev option set on /home partition (Scored)" {
    run bash -c "mount | grep -E '\s/home\s' | grep -v nodev"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.19 Ensure nodev option set on removable media partitions (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.20 Ensure nosuid option set on removable media partitions (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.21 Ensure noexec option set on removable media partitions (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "1.1.22 Ensure sticky bit is set on all world-writable directories (Scored)" {
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null"
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "1.1.23 Disable Automounting (Scored)" {
    run bash -c "systemctl is-enabled autofs"
    if [ "$status" -eq 0 ]; then
        [ "$output" != "enabled" ]
    fi
}

@test "1.1.24 Disable USB Storage (Scored)" {
    run bash -c "modprobe -n -v usb-storage"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep usb-storage"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}
