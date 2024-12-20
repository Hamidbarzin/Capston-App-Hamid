//
//  ProfileViewController.swift
//  topping app
//
//  Created by Hamidreza Zebardast on 12/18/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        
        guard let user = UserManager.shared.activeUser else {
            let informationText = """
User: Google 
Name: Google
Email: user@gmail.com
"""
            informationLabel.text = informationText
            return
        }
        
        if let userImage = user.avatar.flatMap(UIImage.init) {
            imageView.image = userImage
        }
        let informationText = """
User: \(user.username)
Name: \(user.fullName)
Email: \(user.email)
"""
        informationLabel.text = informationText
    }
    
    @IBAction func logoutButtonDidTouch(_ sender: UIButton) {
        UserManager.shared.logout()
        if let vc = SceneDelegate.mainStoryboard?.instantiateViewController(identifier: "Auth") {
            SceneDelegate.currentDelegate?.changeRootViewControllerIfPossible(vc)
        }
    }
}
