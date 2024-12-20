import UIKit
import GoogleSignIn

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // فیلدهای ثبت‌نام
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    func navigateToHomeIfPossible() {
        if let vc = SceneDelegate.mainStoryboard?.instantiateViewController(identifier: "MainTab") {
            SceneDelegate.currentDelegate?.changeRootViewControllerIfPossible(vc)
        }
    }
    
    @IBAction func signInGoogleDidTouch(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            self?.navigateToHomeIfPossible()
        }
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           configureUI()
       }
       
       // تنظیمات اولیه
       private func configureUI() {
           // استایل برای TextFieldها
           [fullNameTextField, emailTextField, phoneTextField, usernameTextField, passwordTextField, confirmPasswordTextField].forEach {
               $0?.layer.borderWidth = 1
               $0?.layer.borderColor = UIColor.gray.cgColor
               $0?.layer.cornerRadius = 8
               $0?.setLeftPaddingPoints(10)
           }
           
           // تنظیمات UIImageView برای پروفایل
           profileImageView.layer.borderWidth = 1
           profileImageView.layer.borderColor = UIColor.gray.cgColor
           profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
           profileImageView.clipsToBounds = true
           profileImageView.contentMode = .scaleAspectFill
       }
       
       // عملکرد دکمه ثبت‌نام
       @IBAction func signUpButtonTapped(_ sender: UIButton) {
           
           guard let fullName = fullNameTextField.text, !fullName.isEmpty,
                 let email = emailTextField.text, isValidEmail(email),
                 let phone = phoneTextField.text, isValidPhone(phone),
                 let username = usernameTextField.text, !username.isEmpty else {
               showAlert(message: "لطفاً تمامی فیلدها را به درستی پر کنید.")
               return
           }
           
           guard let password = passwordTextField.text, password.count >= 6,
                 let confirmPassword = confirmPasswordTextField.text, confirmPassword == password else {
               showAlert(message: "رمز عبور باید ۶ رقم به بالا باشد و ۲ بار به درستی وارد شود")
               return
           }
           
           
           let avatar = profileImageView.image?.jpegData(compressionQuality: 1)
           
           // ذخیره اطلاعات کاربر
           UserManager.shared.addUserAndActive(
            UserModel(
                username: username,
                fullName: fullName,
                avatar: avatar,
                email: email,
                password: password,
                phoneNumber: phone,
                isActive: true
            )
           )
           
           navigateToHomeIfPossible()
       }
       
       // عملکرد دکمه انتخاب عکس
       @IBAction func selectProfileImageTapped(_ sender: UIButton) {
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.sourceType = .photoLibrary
           imagePicker.allowsEditing = true
           present(imagePicker, animated: true, completion: nil)
       }
       
       // متد انتخاب عکس
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
           picker.dismiss(animated: true, completion: nil)
           if let selectedImage = info[.editedImage] as? UIImage {
               profileImageView.image = selectedImage
           }
       }
       
       // متد لغو انتخاب عکس
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
       
       // نمایش پیام هشدار
       private func showAlert(message: String) {
           let alert = UIAlertController(title: "اطلاع", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
       
       // اعتبارسنجی ایمیل
       private func isValidEmail(_ email: String) -> Bool {
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
       }
       
       // اعتبارسنجی شماره تلفن
       private func isValidPhone(_ phone: String) -> Bool {
           let phoneRegex = "^[+]?[0-9]{10,15}$"
           return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
       }
   }

   // Extension برای افزودن Padding به TextField
   extension UITextField {
       func setLeftPaddingPoints(_ amount: CGFloat) {
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
           self.leftView = paddingView
           self.leftViewMode = .always
       }
   }
