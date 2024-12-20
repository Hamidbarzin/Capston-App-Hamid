import UIKit
import CoreLocation

class OrderViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    var priceText: String = ""
    var receipt: ReceiptModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        sourceLabel.text = "Source: \(receipt.address!.shipFromAddress)"
        destinationLabel.text = "Destination: \(receipt.address!.shipToAddress)"
        
        calculatePrice()
    }
    
    private func calculatePrice() {
        priceLabel.text = "Please Wait..."
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            let startLocation = CLLocation(latitude: receipt.address!.shipFromCoordinates.latitude, longitude: receipt.address!.shipFromCoordinates.longitude)
            let endLocation = CLLocation(latitude: receipt.address!.shipToCoordinates.latitude, longitude: receipt.address!.shipToCoordinates.longitude)
            let distanceInMeters = startLocation.distance(from: endLocation)
            let distanceInKilometers = distanceInMeters / 1000
            
            let pricePerKilometer = 2.0 // Example price per kilometer
            let price = distanceInKilometers * pricePerKilometer
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            let priceString = currencyFormatter.string(from: NSNumber(value: price))
            
            priceLabel.text = "Price: \(priceString ?? "")"
            continueButton.isEnabled = true
            priceText = priceString ?? ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShipFromDetailsViewController
        receipt.priceText = priceText
        vc.receipt = receipt
    }
    
    @IBAction func continueButtonDidTouch(_ sender: UIButton) {
        
    }
}
