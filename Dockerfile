# Dockerfile
FROM python:3.9
WORKDIR /app
COPY Can-Lookup/requirements.txt .
RUN pip install -r requirements.txt
COPY Can-Lookup/ .
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]