#!/bin/bash
set -e

echo "📦 [Step 3] Deploying PostGIS Database..."

SECRET_FILE="kubernetes/database/postgres-secret.yaml"
if [ ! -f "$SECRET_FILE" ]; then
    echo "❌ ERROR: Secret file not found at $SECRET_FILE!"
    echo "   Please create this file (it is ignored by git) before deploying."
    exit 1
fi

echo "🔐 Applying Secrets..."
kubectl apply -f $SECRET_FILE

echo "💾 Applying Persistent Volumes, Services, and StatefulSets..."
kubectl apply -f kubernetes/database/

echo "✅ Database deployed."