#!/bin/bash
echo "Removing old storage"
sudo rm -rf /data/wp_html
sudo rm -f /data/wp_db

echo "Creating new storage"
sudo mkdir -p /data/wp_html
sudo chcon -t container_file_t /data/wp_html

sudo mkdir -p /data/wp_db
sudo chcon -t container_file_t /data/wp_db

