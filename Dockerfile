# Dockerfile
FROM python:3.9
WORKDIR /Can-Lookup
COPY Can-Lookup/requirements.txt /Can-Lookup/
RUN pip install -r requirements.txt
COPY Can-Lookup/ /Can-Lookup
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]