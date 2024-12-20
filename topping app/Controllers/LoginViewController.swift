
import UIKit
import GoogleSignIn

class Loginviewcontroller: UIViewController {
    let sequeIdentifier = "loginToOrderViewcontroller"
    
    @IBOutlet weak var googleLogin: UIButton!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var PasswordTextfield: UITextField!
  
    @IBAction func signInWithGoogleDidTouch(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            self?.navigateToHomeIfPossible()
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let username = usernameTextfield.text, !username.isEmpty else {
            showAlert(message: "لطفا نام کاربری وارد کنید")
            return
        }
        
        guard let password = PasswordTextfield.text, !password.isEmpty else {
            showAlert(message: "لطفا رمز عبور وارد کنید")
            return
        }
        
        if UserManager.shared.isUserExistAndLogin(
            username: username,
            password: password
        ) {
            navigateToHomeIfPossible()
        } else {
            showAlert(message: "نام کاربری و رمز عبور اشتباه است")
        }
    }
    
    func navigateToHomeIfPossible() {
        if let vc = SceneDelegate.mainStoryboard?.instantiateViewController(identifier: "MainTab") {
            SceneDelegate.currentDelegate?.changeRootViewControllerIfPossible(vc)
        }
    }
    
    // نمایش پیام هشدار
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "اطلاع", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
