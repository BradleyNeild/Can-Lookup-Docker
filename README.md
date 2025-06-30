## Prerequisites

- Docker installed on the host machine.
- Docker Compose installed on the host machine.
- Git (if cloning the repository).

## Quick Start

1. **Clone the Repository**
   ```bash
   git clone https://github.com/BradleyNeild/Can-Lookup-Docker.git
   cd Can-Lookup-Docker
   ```

2. **Environment Configuration**

   Copy the `dotenv.example` file to a new file named `.env` and update the environment variables with your actual values:

   ```bash
   copy dotenv.example .env
   ```
   Then edit the `.env` file with your preferred text editor.

   Fill in the environment variables such as database configurations and AWS credentials. For local development, the default values should be sufficient.

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

5. **Access the Application**

   The application should now be accessible at http://localhost or http://127.0.0.1.

## Configuration

Details on the environment variables can be found in the `dotenv.example` file.

### Storage Backend

By default, this project uses local file storage for uploaded files. To use AWS S3 for storage, you will need an AWS account and an S3 bucket.

-   Set `USE_AWS=True` in your `.env` file to enable AWS S3 storage.
-   If `USE_AWS` is `False` or not set, the application will use the local filesystem for media and static files.

When using AWS, you must provide your credentials and bucket details in the `.env` file.

## Running the Application

This project uses a unified Docker Compose setup for both development and production, with development settings automatically applied via a `docker-compose.override.yml` file.

### Running in Development Mode

For local development, which features live-reloading, simply run:

```bash
docker-compose up --build -d
```

Docker Compose will automatically merge `docker-compose.yml` and `docker-compose.override.yml` to create the development configuration. The application will be available at http://localhost:8000.

After the first run, you can start and stop the application with `docker-compose up -d` and `docker-compose down`.

### Running in Production Mode

The base `docker-compose.yml` file is configured for production and uses a Gunicorn server. To run in production mode, you explicitly specify only this file, which tells Docker Compose to ignore the development override file:

```bash
docker-compose -f docker-compose.yml up --build -d
```

The application will be available at http://localhost:80. Before running in production, ensure that `DEBUG` is set to `False` in your `.env` file.

### Applying Database Migrations

You must run migrations after starting the application for the first time. The command is the same for both environments:

```bash
docker-compose exec web python manage.py migrate
```

### Environment Variables
-   `USE_AWS`: Set to `True` to use AWS S3 for file storage. Defaults to `False`.
-   `DJANGO_SECRET_KEY`: A secret key for a particular Django installation.
-   `DJANGO_DEBUG`: Set this to `False` for production.
-   `DJANGO_ALLOWED_HOSTS`: List of strings representing the host/domain names that this Django site can serve. For local development, `localhost,127.0.0.1` is used.
-   `POSTGRES_DB`: The database name.
-   `POSTGRES_USER`: The user for the database.
-   `POSTGRES_PASSWORD`: The password for the database user.
-   `POSTGRES_HOST`: The hostname for the database. This is `db` by default, which is the name of the database service in `docker-compose.yml`.
-   `POSTGRES_PORT`: The port for the database.
-   `AWS_ACCESS_KEY_ID`: Your AWS access key for S3 storage.
-   `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key for S3 storage.
-   `AWS_MEDIA_STORAGE_BUCKET_NAME`: The name of the S3 bucket used for media files.
-   `AWS_STATIC_STORAGE_BUCKET_NAME`: The name of the S3 bucket used for static files.
-   `AWS_S3_REGION_NAME`: The AWS region where your S3 bucket is located.
-   `DJANGO_CSRF_TRUSTED_ORIGINS`: A list of trusted origins for unsafe requests (e.g. `