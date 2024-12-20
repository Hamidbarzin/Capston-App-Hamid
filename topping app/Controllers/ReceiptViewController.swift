import UIKit
import Lottie

class ReceiptViewController: UIViewController {
    
    @IBOutlet weak var animationViewContainer: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var packagingLabel: UILabel!
    @IBOutlet weak var shipToLabel: UILabel!
    @IBOutlet weak var shipFromLabel: UILabel!
    var receipt: ReceiptModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        Task {
            try await setupAnimation()
        }
    }
    
    private func setup() {
        shipFromLabel.text = """
\(receipt.shipFrom!.name)
\(receipt.shipFrom!.contact)
\(receipt.shipFrom!.email)
\(receipt.shipFrom!.phone)
"""
        
        shipToLabel.text = """
\(receipt.shipTo!.contact)
\(receipt.shipTo!.name)
\(receipt.shipTo!.email)
\(receipt.shipTo!.phone)
\(receipt.shipTo!.postalCode)
"""
        
        packagingLabel.text = """
Length: \(receipt.shipTo!.length)
Weight: \(receipt.shipTo!.weight)
Width: \(receipt.shipTo!.width)
Height: \(receipt.shipTo!.height)
"""
        
        priceLabel.text = """
\(receipt.priceText!)
"""
    }
    
    @IBAction func backButtonDidTouch(_ sender: UIButton) {
        parent?.parent?.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupAnimation() async throws {
        let animationURL = Bundle.main.url(forResource: "Success", withExtension: "lottie")!
        let animationView = await LottieAnimationView(dotLottie: try DotLottieFile.loadedFrom(url: animationURL))
        animationViewContainer.addSubview(animationView)
        animationView.frame = animationViewContainer.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.parent?.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        parent?.parent?.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
