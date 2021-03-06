#!./parrot
# Copyright (C) 2006-2010, Parrot Foundation.

=head1 NAME

t/pmc/socket.t - test the Socket PMC

=head1 SYNOPSIS

    % prove t/pmc/socket.t

=head1 DESCRIPTION

Tests the Socket PMC.

=cut

.include 'socket.pasm'
.sub main :main
    .include 'test_more.pir'

    plan(19)

    test_init()
    test_get_fd()
    test_read()
    test_readline()
    test_clone()
    test_bool()
    test_close()
    test_is_closed()
    test_tcp_socket()
    test_tcp_socket6()
    test_raw_tcp_socket()
    test_raw_tcp_socket6()
    test_udp_socket()
    test_udp_socket6()
    test_raw_udp_socket()
    test_raw_udp_socket6()

.end

.sub test_init
    new $P0, ['Socket']
    ok(1, 'Instantiated a Socket PMC')

    $S0 = typeof $P0
    is($S0, 'Socket', 'PMC has correct type')
.end

.sub test_get_fd
    new $P0, ['Socket']
    $N0 = $P0.'get_fd'()
    ok(1, "can get_fd a Socket")
.end

.sub test_read
    new $P0, ['Socket']
    $N0 = $P0.'read'(5)
    is($N0, 0, 'Socket read returns 0 when not connected')
.end

.sub test_readline
    new $P0, ['Socket']
    $N0 = $P0.'readline'()
    is($N0, 0, 'Socket readline returns 0 when not connected')
.end

.sub test_bool
    new $P0, ['Socket']
    nok($P0, 'get_bool on closed Socket')
.end

.sub test_close
    new $P0, ['Socket']
    $P0.'close'()
    ok(1, 'Closed a Socket')
    nok($P0,'A closed Socket returns False')
.end

.sub test_is_closed
    new $P0, ['Socket']

    $N0 = $P0.'is_closed'()
    is($N0, 1, 'Socket is_closed returned 1 to new socket')
.end

.sub test_clone
    new $P0, ['Socket']
    $P1 = $P0."sockaddr"("localhost", 1234)

    $P2 = clone $P0
    ok(1, 'Cloned a Socket PMC')

    $S0 = typeof $P2
    $S1 = 'Socket'

    $I0 = iseq $S0, $S1
    ok($I0, 'Cloned PMC has correct type TT#1820')
.end

.sub test_tcp_socket
    .local pmc sock
    sock = new 'Socket'
    sock.'socket'(.PIO_PF_INET, .PIO_SOCK_STREAM, .PIO_PROTO_TCP)
    ok(1, 'Created a TCP Socket')
.end

.sub test_tcp_socket6
    .local pmc sock
    sock = new 'Socket'
    sock.'socket'(.PIO_PF_INET6, .PIO_SOCK_STREAM, .PIO_PROTO_TCP)
    ok(1, 'Created a IPv6 TCP Socket')
.end

.sub test_raw_tcp_socket6
    .local pmc sock
    sock = new 'Socket'
    sock.'socket'(.PIO_PF_INET6, .PIO_SOCK_RAW, .PIO_PROTO_TCP)
    ok(1, 'Created a raw IPv6 TCP Socket')
.end

.sub test_udp_socket6
    .local pmc sock
    sock = new 'Socket'

    sock.'socket'(.PIO_PF_INET6, .PIO_SOCK_STREAM, .PIO_PROTO_UDP)
    ok(1, 'Created a IPv6 UDP Socket')
.end

.sub test_raw_udp_socket6
    .local pmc sock
    sock = new 'Socket'

    sock.'socket'(.PIO_PF_INET6, .PIO_SOCK_RAW, .PIO_PROTO_UDP)
    ok(1, 'Created a raw IPv6 UDP Socket')
.end

.sub test_raw_tcp_socket
    .local pmc sock
    sock = new 'Socket'
    sock.'socket'(.PIO_PF_INET, .PIO_SOCK_RAW, .PIO_PROTO_TCP)
    ok(1, 'Created a raw TCP Socket')
.end

.sub test_udp_socket
    .local pmc sock
    sock = new 'Socket'

    sock.'socket'(.PIO_PF_INET, .PIO_SOCK_STREAM, .PIO_PROTO_UDP)
    ok(1, 'Created a UDP Socket')
.end

.sub test_raw_udp_socket
    .local pmc sock
    sock = new 'Socket'

    sock.'socket'(.PIO_PF_INET, .PIO_SOCK_RAW, .PIO_PROTO_UDP)
    ok(1, 'Created a raw UDP Socket')
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
