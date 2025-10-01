FROM python:3.10-slim-bullseye

# Install dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
WORKDIR /app
COPY . /app/

# Install Python requirements
RUN pip3 install --no-cache-dir --upgrade -r requirements.txt

# Environment variable
ENV COOKIES_FILE_PATH="/youtube_cookies.txt"

# Start the app
CMD gunicorn app:app & python3 main.py
