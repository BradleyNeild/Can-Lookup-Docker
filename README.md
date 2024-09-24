## Prerequisites

- Docker installed on the host machine.
- Docker Compose installed on the host machine.
- Git (if cloning the repository).
- Access to the private repository https://github.com/BradleyNeild/CanLookup.

## Quick Start

1. **Clone the Repository**
   ```bash
   git clone https://github.com/BradleyNeild/CanLookup-Docker.git
   cd CanLookup-Docker
   git clone https://github.com/BradleyNeild/CanLookup.git
   ```

2. **Environment Configuration**

   Copy the `.env.example` file to a new file named `.env` and update the environment variables with the actual values:

   ```bash
   cp .env.example .env
   nano .env  # Or use your preferred text editor
   ```

   Fill in the environment variables such as database configurations and AWS credentials.

3. **Build and Run the Docker Containers**

   Use Docker Compose to build and start the containers:

   ```bash
   docker-compose up --build -d
   ```

   The `-d` flag runs the containers in detached mode.

4. **Database Migrations**

   After starting the containers, run the database migrations:

   ```bash
   docker-compose exec web python manage.py migrate
   ```

5. **Collect Static Files** (if using Django's static file serving)

   Collect the static files:

   ```bash
   docker-compose exec web python manage.py collectstatic
   ```

6. **Access the Application**

   The application should now be accessible at the host's IP address or domain name configured in `ALLOWED_HOSTS`.

## Configuration

Details on the environment variables:

- `DJANGO_SECRET_KEY`: A secret key for a particular Django installation.
- `DJANGO_DEBUG`: Set this to `False` for production.
- `DJANGO_ALLOWED_HOSTS`: List of strings representing the host/domain names that this Django site can serve.
- `POSTGRES_DB`: The database name.
- `POSTGRES_USER`: The user for the database.
- `POSTGRES_PASSWORD`: The password for the database user.
- `AWS_ACCESS_KEY_ID`: Your AWS access key for S3 storage.
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key for S3 storage.
- `AWS_STORAGE_BUCKET_NAME`: The name of the S3 bucket used for static files.
- `AWS_S3_REGION_NAME`: The AWS region where your S3 bucket is located.

## Troubleshooting

- If you encounter any issues with database connectivity, ensure that the `POSTGRES_*` environment variables match the credentials of the TimescaleDB service and that the service is ready before attempting to connect.

- For issues related to static files, verify the AWS credentials and bucket configuration.
