# -------------------------------
# Namespace Creation Function
# -------------------------------
create_namespace() {
    NS_NAME=$1

    if ip netns list | grep -qw "$NS_NAME"; then
        warn "Namespace $NS_NAME already exists — skipping creation."
    else
        ip netns add "$NS_NAME"
        success "Namespace $NS_NAME created successfully."
    fi
}
