import UIKit

class SplashViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManager.shared.activeUser == nil {
            showAuthIfPossible()
        } else {
            navigateToHomeIfPossible()
        }
    }
    
    func navigateToHomeIfPossible() {
        if let vc = SceneDelegate.mainStoryboard?.instantiateViewController(identifier: "MainTab") {
            SceneDelegate.currentDelegate?.changeRootViewControllerIfPossible(vc)
        }
    }
    
    func showAuthIfPossible() {
        if let vc = SceneDelegate.mainStoryboard?.instantiateViewController(identifier: "Auth") {
            SceneDelegate.currentDelegate?.changeRootViewControllerIfPossible(vc)
        }
    }
}
