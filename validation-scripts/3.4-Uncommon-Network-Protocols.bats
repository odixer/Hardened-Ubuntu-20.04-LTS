#!/usr/bin/env bats

@test "3.4.1 Ensure DCCP is disabled (Scored)" {
    run bash -c "modprobe -n -v dccp"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep dccp"
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}

@test "3.4.2 Ensure SCTP is disabled (Scored)" {
    run bash -c "modprobe -n -v sctp"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep sctp"
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}

@test "3.4.3 Ensure RDS is disabled (Scored)" {
    run bash -c "modprobe -n -v rds"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep rds"
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}

@test "3.4.4 Ensure TIPC is disabled (Scored)" {
    (modprobe -n -v tipc | grep "install /bin/true")
    run bash -c "lsmod | grep tipc"
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}