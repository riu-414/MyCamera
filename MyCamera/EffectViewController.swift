//
//  EffectViewController.swift
//  MyCamera
//
//  Created by 大杉祐弥 on 2022/01/22.
//

import UIKit

class EffectViewController: UIViewController {
    
    @IBOutlet weak var effectImageView: UIImageView!
    
    var originalImage : UIImage?
    
    let filterArray = ["CIPhotoEffectMono",
                       "CIPhotoEffectChrome",
                       "CIPhotoEffectFade",
                       "CIPhotoEffectInstant",
                       "CIPhotoEffectNoir",
                       "CIPhotoEffectProcess",
                       "CIPhotoEffectTonal",
                       "CIPhotoEffectTransfer",
                       "CISepiaTone"]
    
    var filterSelectNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        effectImageView.image = originalImage

        // Do any additional setup after loading the view.
    }
    
    @IBAction func effectButton(_ sender: Any) {
        if let image = originalImage {
            let filterName = filterArray[filterSelectNumber]
            filterSelectNumber += 1
            if filterSelectNumber == filterArray.count {
                filterSelectNumber = 0
            }
            let rotate = image.imageOrientation
            let inputImage = CIImage(image: image)
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            effectFilter.setDefaults()
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            let ciContext = CIContext(options: nil)
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            effectImageView.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        if let shareImage = effectImageView.image {
            let shareImages = [shareImage]
            let controller = UIActivityViewController(activityItems: shareImages, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
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
