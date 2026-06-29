#!/bin/bash
set -e

echo "⏳ [Step 2] Creating k3d cluster 'geotour-cluster'..."

if k3d cluster list | grep -q "geotour-cluster"; then
    echo "⚠️  Cluster 'geotour-cluster' already exists. Skipping creation."
else
    k3d cluster create geotour-cluster -p "8080:80@loadbalancer"
    echo "✅ Cluster created successfully."
fi