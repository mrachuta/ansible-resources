#!/usr/bin/env bash
set -xeu -o pipefail

# Set the directory for Prometheus metrics
METRICS_DIR="/var/lib/node_exporter/textfile_collector"
PROM_FILE="$METRICS_DIR/node_updates.prom"
TMP_FILE="$PROM_FILE.$$"

# Ensure the metrics directory exists
mkdir -p "$METRICS_DIR"

# Determine the package manager and get update counts
if command -v apt-get &> /dev/null; then
    # For Debian/Ubuntu
    # Update package list silently
    apt-get update -qq > /dev/null
    
    # Get the number of upgradable packages
    UPDATES=$(apt-get -s upgrade | grep -P '^\d+ upgraded' | cut -d' ' -f1 || true)
    # Get security-specific updates
    SECURITY_UPDATES=$(apt-get -s upgrade | grep -ci security || true)

elif command -v dnf &> /dev/null; then
    # For RHEL/CentOS 8+, Fedora, OL
    UPDATES=$(dnf list updates | grep -A9999 "Available Upgrades" | tail -n +2 | wc -l || true)
    SECURITY_UPDATES=$(dnf list updates --security | grep -A9999 "Available Upgrades" | tail -n +2 | wc -l || true)
else
    echo "No supported package manager found."
    exit 1
fi

# Ensure values are numbers, default to 0 if empty
UPDATES=${UPDATES:-0}
SECURITY_UPDATES=${SECURITY_UPDATES:-0}

# Create the metrics file content
# Use a temporary file and atomic move to prevent partial reads
cat <<EOF > "$TMP_FILE"
# HELP node_os_updates_pending Number of pending OS updates.
# TYPE node_os_updates_pending gauge
node_os_updates_pending{type="all"} $UPDATES
node_os_updates_pending{type="security"} $SECURITY_UPDATES
EOF

# Atomically move the temporary file to its final destination
mv "$TMP_FILE" "$PROM_FILE"
chmod 775 "$PROM_FILE"
