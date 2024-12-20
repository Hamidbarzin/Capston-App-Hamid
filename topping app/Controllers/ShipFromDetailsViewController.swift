import UIKit

class ShipFromDetailsViewController: UIViewController {

    @IBOutlet weak var contactTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    var receipt: ReceiptModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.parent?.title = "Ship From Details"
    }
    
    @IBAction func textFieldsDidChanged(_ sender: UITextField) {
        continueButton.isEnabled = validateTextfields()
    }
    
    func validateTextfields() -> Bool {
        contactTextfield.text?.isEmpty == false
        && nameTextfield.text?.isEmpty == false
        && emailTextfield.text?.isEmpty == false
        && phoneTextfield.text?.isEmpty == false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShipToDetailsViewController
        receipt.shipFrom = ShipFromModel(
            contact: contactTextfield.text!,
            name: nameTextfield.text!,
            email: emailTextfield.text!,
            phone: phoneTextfield.text!
        )
        vc.receipt = receipt
    }
}
