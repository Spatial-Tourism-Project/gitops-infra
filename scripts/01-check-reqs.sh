#!/bin/bash
set -e

echo "🔍 [Step 1] Checking System Requirements..."
REQUIREMENTS_FILE="infra-requirements.txt"

if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "❌ ERROR: Requirements file '$REQUIREMENTS_FILE' not found!"
    exit 1
fi

while IFS='|' read -r tool_name install_cmd || [ -n "$tool_name" ]; do
    tool_name=$(echo "$tool_name" | tr -d '\r' | xargs)
    install_cmd=$(echo "$install_cmd" | tr -d '\r' | xargs)

    [[ -z "$tool_name" || "$tool_name" == \#* ]] && continue

    if ! command -v "$tool_name" &> /dev/null; then
        echo "❌ Missing: $tool_name"
        echo "   💡 To install via CLI, run: $install_cmd"
        exit 1
    else
        # Safe version check to avoid the kubectl flag error
        if [ "$tool_name" == "kubectl" ]; then
            version=$(kubectl version --client --short 2>/dev/null | awk '{print $3}' || echo "installed")
        else
            version=$($tool_name --version 2>&1 | head -n 1 | awk '{print $1, $2, $3}')
        fi
        echo "✅ Found $tool_name ($version)"
    fi
done < "$REQUIREMENTS_FILE"

echo "🎉 All required tools are installed!"