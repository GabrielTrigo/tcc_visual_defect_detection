from ultralytics import YOLO
import cv2
import math
import sys
import os

HOME = os.getcwd()
IMAGE_PATH = sys.argv[1]
OUTPUT_IMAGE_PATH = sys.argv[2]

model = YOLO(f'{HOME}/runs/detect/train/weights/best.pt')

# object classes
classNames = ["broken", "good"]


def segment_image(image_path):
    try:

        img = cv2.imread(image_path)
        results = model(img, stream=True)

        # coordinates
        for r in results:
            boxes = r.boxes

            for box in boxes:
                # bounding box
                x1, y1, x2, y2 = box.xyxy[0]
                x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)

                # confidence
                confidence = math.ceil((box.conf[0] * 100)) / 100
                print(f"confidence: {confidence}", end='\r\n')

                # class name
                cls = int(box.cls[0])
                print(f"class_name: {classNames[cls]}", end='\r\n')

                # object details
                org = [x1, y1]
                font = cv2.FONT_HERSHEY_SIMPLEX
                font_scale = 1
                color = (255, 0, 0)
                thickness = 2

                cv2.putText(img, classNames[cls], org, font, font_scale, color, thickness)

                if classNames[cls] == "good":
                    box_color = (0, 255, 0)
                else:
                    box_color = (0, 0, 255)

                # put box in cam
                cv2.rectangle(img, (x1, y1), (x2, y2), box_color, 3)

        cv2.imshow('Segmented', img)

        cv2.imwrite(OUTPUT_IMAGE_PATH, img)
        cv2.destroyAllWindows()

        return "status: true"
    except Exception as e:
        return f"status: {e}"


result = segment_image(IMAGE_PATH)
print(result, end='\r\n')