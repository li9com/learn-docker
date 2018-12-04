#!/bin/bash
echo "Removing old storage"
sudo rm -rf /data/registry

echo "Creating new storage"
sudo mkdir -p /data/registry
sudo chcon -t container_file_t /data/registry
