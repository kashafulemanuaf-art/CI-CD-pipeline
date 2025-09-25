# Use a slim, stable Python version (avoid "latest" for consistency)
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app source code
COPY . .

# Expose port (matches app.py -> 8000)
EXPOSE 8000

# Run the app
CMD ["python", "app.py"]