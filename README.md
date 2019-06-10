# EthnicityApp
This repository stores all codes for iOS application that we created in our Computing Project.

### ViewController and its references .Swift file:  
1. **ViewController.swift:**  
For test use only. This ViewController are used to explore features about AVFoundation, its referenced Controller cannot be accessed in the final product.  
2. **TestLoadingViewController.swift:**  
The main ViewController. Handles the video feed cpatured by AVFoundation and can flip between front and rear camera.   
3. **PreviewViewController.swift:**  
The ViewController that is used to show the prediction. It contains __cancel__ and __save__ buttons.

### mlmodel used in this project:  
* **ResNet_dt2_4.mlmodel:**  
This model is a __ResNet 34__ model and trained based on the __UTK Face__ dataset.
* **ResNet_fp_1.mlmodel:**  
This model is trained based on the __Face Place__ dataset, since the size of this .mlmodel file is 81MB which is pretty sapce consuming, therefore we don't include this in the final software.
