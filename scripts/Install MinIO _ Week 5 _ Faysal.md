# Download the official MinIO server binary
wget https://dl.min.io/server/minio/release/linux-amd64/minio

# Make it executable
chmod +x minio

# Move it somewhere the system can find it
sudo mv minio /usr/local/bin/

# Create the folder where MinIO stores its data
mkdir ~/minio-data

# Set the admin credentials (session-only)
export MINIO_ROOT_USER=PG5
export MINIO_ROOT_PASSWORD=PG520265

# Start the MinIO server (leave this terminal running)
minio server ~/minio-data --console-address ":9001"
