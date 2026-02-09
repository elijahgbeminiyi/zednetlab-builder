#!/bin/bash

# Load libraries
source lib/utils.sh
source lib/namespace.sh
source lib/links.sh
source lib/ipconfig.sh
source lib/test.sh

# ===============================
# ZedNetLab Builder v1.0
# Lightweight Networking Lab Tool
# ===============================


clear
echo -e "${GREEN}"
echo "==============================================="
echo "              ZedNetLab Builder"
echo "   Lightweight Linux Network Lab Simulator"
echo "==============================================="
echo -e "${RESET}"

sleep 1

info "This tool will build a virtual networking lab using Linux namespaces."
info "No VMs. No heavy RAM usage. Pure kernel networking."
echo

# -------------------------------
# Privilege Check
# -------------------------------
if [[ $EUID -ne 0 ]]; then
   error "Please run this tool with sudo."
   exit 1
fi


# -------------------------------
# Get User Input
# -------------------------------

read -p "Enter name for CLIENT namespace: " CLIENT_NS
read -p "Enter name for SERVER/ROUTER namespace: " ROUTER_NS
echo

# -------------------------------
# Create Namespaces
# -------------------------------
sleep 1
info "Creating network namespaces..."
create_namespace "$CLIENT_NS"
create_namespace "$ROUTER_NS"
success "Namespaces ready!"

echo
info "Here's the lab structure:"
echo "Client Namespace : $CLIENT_NS"
echo "Router Namespace : $ROUTER_NS"

# ---------------------------
# Create Virtual Cables
# ------------------------
echo
sleep 1
info "Building virtual network cables..."
create_veth_pairs
success "Complete — Virtual wiring done."

# ---------------------------------
# Assign IPs and Configure Route
# ---------------------------------
echo
sleep 1
info "Auto-configuring IP addresses..."
configure_ips
success "Complete — Network intelligence activated."
info "Connectivity testing..."

# -------------------------------
# Test Network Connectivity
# -------------------------------
run_tests

echo
success "Lab environment is fully operational!"
info "You now have a complete virtual network running inside your Linux kernel."

