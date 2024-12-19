### install

```python
conda create -n auto_py310 python=3.10 -y
conda activate auto_py310
pip install autodistill autodistill-grounded-sam autodistill-yolov8
pip install roboflow
```

### Simple Example

```python
import cv2
import supervision as sv
from autodistill_grounded_sam import GroundedSAM
from autodistill.detection import CaptionOntology

# Define an ontology to map class names to our GroundingDINO prompt
ontology_dict = {0: "egg", 1: "bottle", 2: "stone", 3: "ball"}
ontology = CaptionOntology({"egg": "egg", "bottle": "bottle", "stone": "stone", "ball": "ball"})
base_model = GroundedSAM(ontology=ontology)

try:
    # Label all images in a folder
    base_model.label(
        input_folder="./dataset/img3",
        output_folder="./dataset/img3_output"
    )

    # Load an image and the detections (predictions)
    image_path = "./dataset/img3/1000046826.jpg"
    image = cv2.imread(image_path)

    # Get detections for a single image
    detections = base_model.predict(image_path)
    print("Detections: ", detections)

    # Create box and mask annotators
    box_annotator = sv.BoxAnnotator()
    mask_annotator = sv.MaskAnnotator()

    # Annotate bounding boxes on the image
    annotated_image = box_annotator.annotate(scene=image, detections=detections)

    # Annotate masks on the image
    annotated_image = mask_annotator.annotate(scene=annotated_image, detections=detections)

    # Map class IDs (integers) to class names using the ontology dictionary
    class_names = [ontology_dict[int(class_id)] for class_id in detections.class_id]

    # Generate labels combining class names and confidence scores
    labels = [f"{class_name} {confidence:.2f}" for class_name, confidence in zip(class_names, detections.confidence)]

    # Annotate the image with the labels
    label_annotator = sv.LabelAnnotator()
    annotated_image = label_annotator.annotate(scene=annotated_image, detections=detections, labels=labels)

    # Save the annotated image
    output_path = "./dataset/output/1000046826_annotated_with_names.jpg"
    cv2.imwrite(output_path, annotated_image)

    # Display the annotated image
    cv2.imshow("Labeled Image", annotated_image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

except KeyboardInterrupt:
    print("Process interrupted. Exiting gracefully...")

```

### Trouble shootings

- if you load torch fails.. : https://github.com/autodistill/autodistill/issues/15

- Padding True issues
    
    ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/cfdb4deb-cc97-49b1-8a43-e6ac4de07746/b407c6ac-4014-45b6-944c-a30224731ea1/image.png)
    
    supervision 0.22.0을 다시 까니깐 되는 듯 
    

## Modules

- supervision
    - sv.BoxAnnotator()
    - sv.MaskAnnotator()
    - sv.LabelAnnotator()

- custom combine model
    - https://github.com/roboflow/awesome-openai-vision-api-experiments/issues/12

# Function

- compare
    - 말그대로 그냥 둘다 실행 후 보여줌
    - https://docs.autodistill.com/utilities/compare-models/

---

https://docs.ultralytics.com/datasets/segment/#generate-segmentation-dataset-using-a-detection-model 여기에서도 auto label tool이 있음