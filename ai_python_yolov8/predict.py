from ultralytics import YOLO

# Load a model
model = YOLO('runs/detect/train/weights/best.pt')

# Predict with the model
results = model.predict([
    "E:/temp/data/train/images/bc1.png",
    "E:/temp/data/train/images/bc2.png",
    "E:/temp/data/train/images/bc3.png",
    "E:/temp/data/train/images/bc4.png",

    "E:/temp/data/train/images/c1.png",
    "E:/temp/data/train/images/c2.png",
    "E:/temp/data/train/images/c3.png",
    "E:/temp/data/train/images/c4.png",
], save=True)
