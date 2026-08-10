# Refresh the package list
sudo apt update

# Install the Restic backup engine
sudo apt install restic -y

# Confirm it installed (returned version 0.18.1)
restic version

# Capture identity + version together for evidence
whoami && hostname && restic version
