# MinIO and Restic — Configuration Reference _ Faysal
Setup reference for the backup environment. NO real credentials are stored here.

## MinIO
- Started with: `minio server ~/minio-data --console-address ":9001"`
- API port: 9000 (used by Restic) | Console port: 9001 (browser login)
- Data stored on disk in ~/minio-data
- Bucket: test-01-ag3-backups
- Runs in the foreground — kept in its own terminal

## Restic
- Repository points at the MinIO bucket over the S3 API (port 9000)
- Repository is encrypted; password is required for all access and is stored securely (never committed)

## Session environment variables (values are set locally, not stored here)
- AWS_ACCESS_KEY_ID (MinIO access key)
- AWS_SECRET_ACCESS_KEY (MinIO secret key)
- RESTIC_REPOSITORY (s3:http://localhost:9000/<bucket>)
- RESTIC_PASSWORD (repository encryption password)
