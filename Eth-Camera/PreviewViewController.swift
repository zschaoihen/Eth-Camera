//
//  PreviewViewController.swift
//  Eth-Camera
//
//  Created by 司辰  赵 on 28/5/19.
//  Copyright © 2019 司辰  赵. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var image: UIImage!
    var resultText: String!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
        resultsLabel.text = resultText
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton_TouchUpInside(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
