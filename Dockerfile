# Dockerfile

# ---- Builder Stage ----
FROM python:3.11-slim as builder

WORKDIR /app

# Install dependencies
COPY Can-Lookup/requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir /app/wheels -r requirements.txt


# ---- Final Stage ----
FROM python:3.11-slim

WORKDIR /app

# Create a non-root user
RUN addgroup --system app && adduser --system --group app

# Copy built wheels and install them
COPY --from=builder /app/wheels /wheels
RUN pip install --no-cache /wheels/*

# Copy application code
COPY Can-Lookup/ .

# Create media directory and set ownership
RUN mkdir -p /app/media && \
    chown -R app:app /app/media /app

# Set entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to non-root user
USER app

ENTRYPOINT ["/entrypoint.sh"]

# Default command
CMD ["gunicorn", "canlookup_project.wsgi:application", "--bind", "0.0.0.0:8000"]