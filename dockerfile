# ============================================================
# 1. Base Image
# ============================================================
FROM python:3.10-slim

# Avoid writing pyc files and buffering problems
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ============================================================
# 2. System-level dependencies
# ============================================================
RUN apt-get update && apt-get install -y \
    wget curl git nano build-essential libgl1-mesa-glx libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# 3. Create working directory
# ============================================================
WORKDIR /app

# ============================================================
# 4. Copy project files
# ============================================================
COPY . /app

# ============================================================
# 5. Install Python dependencies
# ============================================================
# Install PyTorch CPU version
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install remaining dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install YOLO (Ultralytics)
RUN pip install --no-cache-dir ultralytics

# ============================================================
# 6. Create required folders
# ============================================================
RUN mkdir -p input Prediction_files Artefacts tmp models

# ============================================================
# 7. Default command to run pipeline
# ============================================================
CMD ["python", "-m", "Pipeline_code.run_pipeline"]
