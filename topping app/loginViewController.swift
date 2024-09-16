
import UIKit

class loginviewcontroller: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
    
    
    
}
