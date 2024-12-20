import UIKit

class ShipToDetailsViewController: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    var receipt: ReceiptModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.parent?.title = "Ship To Details"
    }
    
    @IBAction func finishButtonDidTouch(_ sender: UIButton) {
    }
    
    @IBAction func textFieldChangeEditing(_ sender: UITextField) {
        finishButton.isEnabled = isValidated()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ReceiptViewController
        receipt.shipTo = ShipToModel(
            height: heightTextField.text!,
            width: widthTextField.text!,
            length: lengthTextField.text!,
            weight: weightTextField.text!,
            postalCode: postalCodeTextField.text!,
            phone: phoneTextField.text!,
            email: emailTextField.text!,
            contact: contactTextField.text!,
            name: nameTextField.text!
        )
        vc.receipt = receipt
    }
    
    func isValidated() -> Bool {
        nameTextField.text?.isEmpty == false
        && contactTextField.text?.isEmpty == false
        && emailTextField.text?.isEmpty == false
        && phoneTextField.text?.isEmpty == false
        && postalCodeTextField.text?.isEmpty == false
        && lengthTextField.text?.isEmpty == false
        && widthTextField.text?.isEmpty == false
        && heightTextField.text?.isEmpty == false
        && weightTextField.text?.isEmpty == false
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
