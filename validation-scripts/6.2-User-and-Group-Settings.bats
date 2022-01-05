#!/usr/bin/env bats

script_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

@test "6.2.1 Ensure password fields are not empty (Scored)" {
    run bash -c "awk -F: '(\$2 == \"\" ) { print \$1 \" does not have a password \"}' /etc/shadow"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.2 Ensure root is the only UID 0 account (Scored)" {
    run bash -c "awk -F: '(\$3 == 0) { print \$1 }' /etc/passwd"
    [ "$status" -eq 0 ]
    [[ "$output" == "root" ]]
}

@test "6.2.3 Ensure root PATH Integrity (Scored)" {
    run bash "$script_path/validation-scripts/6.2.3.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.4 Ensure all users' home directories exist (Scored)" {
    run bash "$script_path/validation-scripts/6.2.4.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.5 Ensure users' home directories permissions are 750 or more restrictive (Scored)" {
    run bash "$script_path/validation-scripts/6.2.5.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.6 Ensure users own their home directories (Scored)" {
    run bash "$script_path/validation-scripts/6.2.6.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.7 Ensure users' dot files are not group or world writable (Scored)" {
    run bash "$script_path/validation-scripts/6.2.7.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.8 Ensure no users have .forward files (Scored)" {
    run bash "$script_path/validation-scripts/6.2.8.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.9 Ensure no users have .netrc files (Scored)" {
    run bash "$script_path/validation-scripts/6.2.9.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.10 Ensure users' .netrc Files are not group or world accessible (Scored)" {
    run bash "$script_path/validation-scripts/6.2.10.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.11 Ensure no users have .rhosts files (Scored)" {
    run bash "$script_path/validation-scripts/6.2.11.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.12 Ensure all groups in /etc/passwd exist in /etc/group (Scored)" {
    run bash "$script_path/validation-scripts/6.2.12.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.13 Ensure no duplicate UIDs exist (Scored)" {
    run bash "$script_path/validation-scripts/6.2.13.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.14 Ensure no duplicate GIDs exist (Scored)" {
    run bash "$script_path/validation-scripts/6.2.14.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.15 Ensure no duplicate user names exist (Scored)" {
    run bash "$script_path/validation-scripts/6.2.15.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.16 Ensure no duplicate group names exist (Scored)" {
    run bash "$script_path/validation-scripts/6.2.16.sh"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.17 Ensure shadow group is empty (Scored)" {
    run bash -c 'grep ^shadow:[^:]*:[^:]*:[^:]+ /etc/group'
    [ "$status" -ne 0 ]
    [[ "$output" == "" ]]
    local SHADOWGROUP=$(grep shadow /etc/group)
    SHADOWGROUP=(${SHADOWGROUP//shadow:x:/ }) # get the last part from the string
    SHADOWGROUPID=(${SHADOWGROUP//:/ }) # remove everything but the id
    run bash -c "awk -F: '(\$4 == $SHADOWGROUPID) { print }' /etc/passwd"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}
