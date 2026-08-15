# 1. Download the mc binary (Community build — matches your MinIO server)
curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o ~/minio-binaries/mc

# 2. Make it executable and add it to your PATH
chmod +x ~/minio-binaries/mc
export PATH=$PATH:~/minio-binaries/
echo 'export PATH=$PATH:~/minio-binaries/' >> ~/.bashrc

# 3. Confirm it installed
mc --version
