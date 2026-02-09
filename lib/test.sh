# -----------------------------
# Test Network Connections
# -----------------------------

run_tests() {

    echo
    info "Running connectivity diagnostics..."
    echo

    info "1) Client → Router test"
    ip netns exec "$CLIENT_NS" ping -c 2 10.0.3.6 >/dev/null 2>&1 \
        && success "Client can reach Router." \
        || error "Client cannot reach Router."

    info "2) Client → Host test"
    ip netns exec "$CLIENT_NS" ping -c 2 10.0.4.6 >/dev/null 2>&1 \
        && success "Client can reach Host machine." \
        || error "Client cannot reach Host."

    info "3) Host → Client test"
    ping -c 2 10.0.4.1 >/dev/null 2>&1 \
        && success "Host can reach Client namespace." \
        || error "Host cannot reach Client."

    info "4) Router → Host test"
    ip netns exec "$ROUTER_NS" ping -c 2 10.0.3.6 >/dev/null 2>&1 \
        && success "Router can reach Host." \
        || error "Router cannot reach Host."

    info "5) Host → Router test"
    ping -c 2 10.0.3.1 >/dev/null 2>&1 \
        && success "Host can reach Router namespace." \
        || error "Host cannot reach Router."

    echo
    success "Diagnostics complete."
}
