import fitz
import json
import os
import re

# ------------------------------------------------------------
# USER SETTINGS — UPDATE THESE WITH YOUR MEASURED RECTANGLES
# ------------------------------------------------------------

# Example rectangles for Letter portrait (replace with your measurements)
HEADER_RECT = fitz.Rect(50, 720, 550, 780)   # header area
PLOT_RECT   = fitz.Rect(50, 200, 550, 680)   # plot image area
META_RECT   = fitz.Rect(50, 60, 550, 180)    # metadata text area

# Folder containing your PNG images
IMAGE_FOLDER = "plots"

# Template PDF
TEMPLATE_FILE = "plot_template.pdf"

# Metadata JSON file
METADATA_FILE = "metadata.json"

# Output PDF
OUTPUT_FILE = "FinalReport.pdf"


# ------------------------------------------------------------
# LOAD TEMPLATE AND METADATA
# ------------------------------------------------------------

print("Loading template...")
template = fitz.open(TEMPLATE_FILE)
template_page = template[0]

print("Loading metadata...")
with open(METADATA_FILE) as f:
    metadata = json.load(f)

# Build lookup table by ID
meta_by_id = {entry["id"]: entry for entry in metadata}


# ------------------------------------------------------------
# CREATE OUTPUT DOCUMENT
# ------------------------------------------------------------

doc = fitz.open()

# Regex to extract ID from filename
id_pattern = r"_id([A-Za-z0-9]+)\.png$"

# Collect all PNG images
images = sorted(
    f for f in os.listdir(IMAGE_FOLDER)
    if f.lower().endswith(".png")
)

print(f"Found {len(images)} images.")


# ------------------------------------------------------------
# PROCESS EACH IMAGE
# ------------------------------------------------------------

for idx, filename in enumerate(images):
    print(f"Processing {filename}...")

    # Extract ID from filename
    match = re.search(id_pattern, filename)
    if not match:
        print(f"  WARNING: No ID found in filename {filename}, skipping.")
        continue

    img_id = match.group(1)

    if img_id not in meta_by_id:
        print(f"  WARNING: No metadata found for ID {img_id}, skipping.")
        continue

    m = meta_by_id[img_id]

    # Create new page using template size
    page = doc.new_page(
        width=template_page.rect.width,
        height=template_page.rect.height
    )

    # Stamp template as background
    page.show_pdf_page(page.rect, template, 0)

    # Insert plot image
    img_path = os.path.join(IMAGE_FOLDER, filename)
    page.insert_image(PLOT_RECT, filename=img_path, keep_proportion=True)

    # Build metadata text block
    metadata_text = (
        f"Accel ID: {m['accelID']}\n"
        f"Segment: {m['segment']}\n"
        f"Mode: {m['mode']}\n"
        f"Plot Type: {m['plotType']}\n"
        f"Filter: {m['filter']}\n"
        f"RMS: {m['rms']}\n"
        f"Max: {m['max']}\n"
        f"Min: {m['min']}\n"
    )

    # Insert metadata text
    page.insert_textbox(META_RECT, metadata_text, fontsize=10)

    # Dynamic header
    header_text = (
        f"{m['plotType']} – Accel {m['accelID']} – "
        f"Segment {m['segment']} ({m['mode']})"
    )
    page.insert_textbox(HEADER_RECT, header_text, fontsize=14, align=1)

    # Add bookmark
    doc.add_outline(header_text, page=page.number)


# ------------------------------------------------------------
# SAVE OUTPUT
# ------------------------------------------------------------

print(f"Saving PDF to {OUTPUT_FILE}...")
doc.save(OUTPUT_FILE)
doc.close()

print("Done.")
