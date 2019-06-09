//
//  ViewController.swift
//  Eth-Camera
//
//  Created by 司辰  赵 on 27/5/19.
//  Copyright © 2019 司辰  赵. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    
    var captureSession: AVCaptureSession?
    var photoPreviewLayer: AVCaptureVideoPreviewLayer?
    var frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    var backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.2, *){
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            do{
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                photoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                photoPreviewLayer?.frame = view.layer.bounds
                cameraView.layer.addSublayer(photoPreviewLayer!)
                captureSession?.startRunning()
                
            }
            catch{
                print("error")
            }
            
        }
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput?.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOutput!)
    }
    
    func switchToFrontCamera() {
        if frontCamera?.isConnected == true{
            captureSession?.stopRunning()
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            do{
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                photoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                photoPreviewLayer?.frame = view.layer.bounds
                cameraView.layer.addSublayer(photoPreviewLayer!)
                captureSession?.startRunning()
                
            }
            catch{
                print("error")
            }
        }
    }
    
    func switchToBackCamera() {
        if backCamera?.isConnected == true{
            captureSession?.stopRunning()
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            do{
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                photoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                photoPreviewLayer?.frame = view.layer.bounds
                cameraView.layer.addSublayer(photoPreviewLayer!)
                captureSession?.startRunning()
                
            }
            catch{
                print("error")
            }
        }
    }

    @IBAction func flipCamera(_ sender: Any) {
        guard let currentCameraInput: AVCaptureInput = captureSession?.inputs.first else{
            return
        }
        
        if let input = currentCameraInput as? AVCaptureDeviceInput{
            if input.device.position == .back {
                switchToFrontCamera()
            }
            if input.device.position == .front {
                switchToBackCamera()
            }
        }
    }
    
    @IBAction func useFlash(_ sender: Any) {
        
    }
    
    @IBAction func imageCapture(_ sender: Any) {
        guard let capturePhotoOutput = self.capturePhotoOutput else{
            return
        }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer else{
                print("Error")
                return
        }
        
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            return
        }
        let captureImage = UIImage.init(data: imageData, scale: 1.0)
        if let image = captureImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}
