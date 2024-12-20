//
//  photoViewcontrollerViewController.swift
//  topping app
//
//  Created by Hamidreza Zebardast on 2024-12-10.
//

import UIKit

class photoViewcontrollerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var photoimageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        photoimageView.layer.borderWidth = 1
        photoimageView.layer.masksToBounds = false
        photoimageView.layer.borderColor = UIColor.black.cgColor
        photoimageView.layer.cornerRadius = photoimageView.frame.height/2
        photoimageView.clipsToBounds = true
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
                 let savedImage = UIImage(data: imageData) {
                  photoimageView.image = savedImage
              }

    }
    
    func ImagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo
    info: [UIImagePickerController.InfoKey: Any]) {
    picker.dismiss(animated: true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        photoimageView.image = image
        
    }
    
    @IBAction func importphotobuttonDidtouch(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                picker.dismiss(animated: true)
                if let image = info[.originalImage] as? UIImage {
                    photoimageView.image = image
                    
                    // ذخیره عکس به صورت Data در UserDefaults
                    if let imageData = image.jpegData(compressionQuality: 0.8) {
                        UserDefaults.standard.set(imageData, forKey: "profileImage")
                    }
                }
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
        }
