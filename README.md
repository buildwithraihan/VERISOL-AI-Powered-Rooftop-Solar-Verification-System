VeriSol – Triple-Validation Rooftop Solar Verification System
AI + Physics + Geometry Fusion for Satellite-Based Solar Detection

VeriSol is an advanced, end-to-end pipeline designed to verify rooftop solar photovoltaic (PV) installations using satellite imagery.
It integrates deep learning, solar-shadow physics, and roof geometry segmentation to achieve high accuracy, robustness, and auditability, fully aligned with the EcoInnovators Ideathon 2026 requirements.

1. Overview

Given an Excel file containing:

sample_id

latitude

longitude

VeriSol performs the following steps:

Fetches the latest available satellite image (Google Static Maps or ESRI).

Applies a 1200 sqft buffer crop (and uses 2400 sqft if required).

Detects solar PV panels using a segmentation model.

Validates detections using sun–shadow geometric consistency.

Segments the roof to estimate the panel area in square meters.

Fuses detection, physics validation, and geometry quality into a final confidence score.

Generates audit-friendly overlays.

Produces output JSON files as per the required schema.

2. Key Features
Deep Learning PV Detection

YOLOv8/YOLOv9 segmentation model identifies solar panels and produces a mask or bounding boxes.

Shadow Physics Validation

Uses PVLib to compute the sun’s azimuth and elevation for the given location and timestamp.
Extracts shadows from the image and compares predicted vs observed shadow directions and lengths to eliminate look-alikes.

Roof Geometry Segmentation

A UNet-based model identifies roof boundaries and orientation.
Improves the accuracy of panel area estimation and enhances generalization across varied rooftops in India.

Fusion-Based Decision Engine

Combines:

PV detection confidence

Shadow match score

Roof geometry quality

to produce a single final decision metric.

Fully Auditable Outputs

The pipeline generates:

Bounding-box overlays

Mask overlays

QC status (VERIFIABLE / NOT_VERIFIABLE)

Final JSON files per sample

Additional intermediate artifacts

3. Repository Structure
verisol/
│
├── Pipeline_code/
│   ├── run_pipeline.py
│   ├── fetch_image.py
│   ├── buffer_crop.py
│   ├── model_inference.py
│   ├── shadow_engine.py
│   ├── roof_geometry.py
│   ├── area_estimation.py
│   ├── fusion.py
│   ├── qc_status.py
│   ├── generate_overlays.py
│   ├── generate_json.py
│   └── utils.py
│
├── Environment_details/
│   ├── requirements.txt
│   ├── environment.yml
│   └── python_version.txt
│
├── Trained_model_file/
│   ├── yolov8_seg.pt
│   └── roof_unet.pth
│
├── Prediction_files/
├── Artefacts/
├── Model_card/
│   └── modelcard.pdf
│
├── Model_Training_Logs/
│
├── input/
│   └── input.xlsx
│
├── config_example.py
└── README.md

4. Installation
Step 1: Install dependencies

Using pip:

pip install -r Environment_details/requirements.txt


Using conda:

conda env create -f Environment_details/environment.yml
conda activate solarfusionnet

Step 2: Configure API keys

Copy:

config_example.py → config.py


Add the required Google Static Maps API key.

Step 3: Prepare input

Place an Excel file at:

input/input.xlsx


Required columns:

sample_id

latitude

longitude

5. Running the Pipeline

Execute the full pipeline using:

python -m Pipeline_code.run_pipeline


Output locations:

JSON files: Prediction_files/

Overlay images: Artefacts/

Temporary intermediate files: tmp/

6. Output JSON Format

A sample output record is shown below:

{
  "sample_id": 1234,
  "lat": 12.9716,
  "lon": 77.5946,
  "has_solar": true,
  "confidence": 0.86,
  "pv_area_sqm_est": 21.7,
  "buffer_radius_sqft": 1200,
  "qc_status": "VERIFIABLE",
  "bbox_or_mask": "mask:tmp/1234_mask.png",
  "image_metadata": {
    "source": "Google Static Maps",
    "capture_date": "2025-11-28"
  }
}

7. Replacing Placeholder Implementations

The repository includes placeholder (dummy) implementations for demonstration.
These must be replaced with real models before final submission:

YOLOv8/YOLOv9 Segmentation

Modify:

Pipeline_code/model_inference.py

UNet Roof Segmentation

Modify:

Pipeline_code/roof_geometry.py

Shadow Physics Module

Modify:

Pipeline_code/shadow_engine.py


Implement accurate shadow extraction and comparison using PVLib.

Accurate GIS Area Computation

Modify:

Pipeline_code/area_estimation.py


Use zoom-level and latitude-adjusted ground sampling distance.

8. Alignment With Challenge Requirements

VeriSol fulfills all official requirements, including:

Python-based pipeline

Reproducible environment

Satellite-only verification

1200/2400 sqft buffer rule

Solar presence classification

PV area estimation in sqm

QC status assignment

JSON output format

Audit overlays

Model card and training logs

GitHub-based submission

9. Contributors

Team VeriSol
EcoInnovators Ideathon 2026 – College Edition
Roles: AI/ML, GIS, Computer Vision, Solar Physics, Software Engineering.

10. License

This repository is intended solely for academic submission to the EcoInnovators Ideathon 2026.
Commercial usage is not permitted without explicit approval.
