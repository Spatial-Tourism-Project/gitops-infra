#!/bin/bash
set -e

echo "====================================================="
echo "🚀 Spatial Tourism Project: Automated Pipeline"
echo "====================================================="
echo ""

# Execute the modular scripts in order
bash ./scripts/01-check-reqs.sh
echo ""

bash ./scripts/02-create-cluster.sh
echo ""

bash ./scripts/03-deploy-db.sh
echo ""

echo "====================================================="
echo "✅ PIPELINE SUCCESS! Infrastructure is fully running."
echo "   Run 'kubectl get pods' to watch the database boot."
echo "====================================================="