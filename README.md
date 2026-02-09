# ZedNetLab Builder

A lightweight networking lab simulator built using Linux network namespaces.

## Why This Tool?
Traditional labs require multiple VMs and high RAM.
NetLab Builder creates full network topologies using the Linux kernel only.

## Features
- Namespace-based virtual machines
- Automatic IP addressing
- Virtual Ethernet wiring
- Routing configuration
- Built-in connectivity testing

## Requirements
- Linux OS
- iproute2 tools
- sudo privileges

## Usage
```bash
sudo ./netlab.sh
