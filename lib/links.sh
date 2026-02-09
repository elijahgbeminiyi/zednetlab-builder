# ----------------------------
# Creating Virtual Cables
# ----------------------------

create_veth_pairs() {

    info "Creating virtual Ethernet cables (veth pairs)..."
    echo

    # Client side cable
    if ip link show veth-client-pc &>/dev/null; then
        warn "veth-client-pc already exists — skipping."
    else
        ip link add veth-client-pc type veth peer name veth-client-net
        success "Cable created: veth-client-pc <--> veth-client-net"
    fi

    # Server/Router side cable
    if ip link show veth-server-pc &>/dev/null; then
        warn "veth-server-pc already exists — skipping."
    else
        ip link add veth-server-pc type veth peer name veth-server-net
        success "Cable created: veth-server-pc <--> veth-server-net"
    fi

    echo
    info "Placing PC ends of cables inside namespaces..."

    ip link set veth-client-pc netns "$CLIENT_NS"
    ip link set veth-server-pc netns "$ROUTER_NS"

    success "Interfaces moved into namespaces."
}
