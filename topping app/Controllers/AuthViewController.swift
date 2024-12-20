//
//  AuthViewController.swift
//  topping app
//
//  Created by Hamidreza Zebardast on 12/13/24.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var firstChildVC: SignUpViewController = {
        // Load the first child view controller from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        addChild(viewController)
        return viewController
    }()

    private lazy var secondChildVC: Loginviewcontroller = {
        // Load the second child view controller from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "Loginviewcontroller") as! Loginviewcontroller
        addChild(viewController)
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    @IBAction func segmendDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            remove(asChildViewController: secondChildVC)
            add(asChildViewController: firstChildVC)
        } else {
            remove(asChildViewController: firstChildVC)
            add(asChildViewController: secondChildVC)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmendDidChange(segmentControl)
    }
}
