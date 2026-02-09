# ---------------------------------------------
# Assigning IPs and Configuring Routes
# ---------------------------------------------

configure_ips() {

    info "Powering on network interfaces..."
    sleep 1

    # Bring up host-side interfaces
    ip link set veth-client-net up
    ip link set veth-server-net up

    # Bring up namespace loopbacks
    ip netns exec "$CLIENT_NS" ip link set lo up
    ip netns exec "$ROUTER_NS" ip link set lo up

    success "Interfaces activated."
    echo

    info "Assigning automatic IP addresses..."
    sleep 1

    # Auto IP scheme
    CLIENT_IP="10.0.4.1/24"
    ROUTER_CLIENT_SIDE="10.0.3.1/24"
    HOST_ROUTER_SIDE="10.0.3.6/24"
    HOST_CLIENT_SIDE="10.0.4.6/24"

    # Assign inside client namespace
    ip netns exec "$CLIENT_NS" ip addr add $CLIENT_IP dev veth-client-pc
    ip netns exec "$CLIENT_NS" ip link set veth-client-pc up

    # Assign inside router namespace (towards client)
    ip netns exec "$ROUTER_NS" ip addr add $ROUTER_CLIENT_SIDE dev veth-server-pc
    ip netns exec "$ROUTER_NS" ip link set veth-server-pc up

    # Assign host-facing IPs
    ip addr add $HOST_CLIENT_SIDE dev veth-client-net
    ip addr add $HOST_ROUTER_SIDE dev veth-server-net

    success "IP configuration complete."
    echo

    info "Setting up routing..."
    sleep 1

    # Client default route via host-client
    ip netns exec "$CLIENT_NS" ip route add default via 10.0.4.6 dev veth-client-pc

    # Router default route back to host-router network
    ip netns exec "$ROUTER_NS" ip route add default via 10.0.3.6 dev veth-server-pc

    # Host route to client network via router
    #ip route add 10.200.2.0/24 via 10.200.1.1
    #ip route add 10.0.4.0/

    success "Routing configured."
    echo

    info "Lab IP Summary:"
    echo "Client namespace IP: 10.0.4.1"
    echo "Server/Router namespace IP : 10.0.3.1"
    echo "Router IP   : 10.0.3.6"
    echo "Client IP   : 10.0.4.6"
}
