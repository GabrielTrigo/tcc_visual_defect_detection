from ultralytics import YOLO

# Load a model
model = YOLO('yolov8n.yaml').load('yolov8n.pt')  # build from YAML and transfer weights

# Train the model
results = model.train(data='config.yaml', epochs=100)
