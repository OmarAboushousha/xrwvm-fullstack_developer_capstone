FROM python:3.12.0-slim-bookworm

ENV PYTHONBUFFERED=1
ENV PYTHONWRITEBYTECODE=1
ENV APP=/app

WORKDIR $APP

# Create numeric non-root user
RUN addgroup --gid 1000 appgroup \
    && adduser --uid 1000 --ingroup appgroup --disabled-password appuser

# Install dependencies
COPY requirements.txt $APP
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . $APP

# Set permissions
RUN chown -R 1000:1000 $APP

# Make entrypoint executable
RUN chmod +x /app/entrypoint.sh

# Switch to unprivileged user
USER 1000

EXPOSE 8000

ENTRYPOINT ["/bin/sh","/app/entrypoint.sh"]
CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "djangoproj.wsgi"]
