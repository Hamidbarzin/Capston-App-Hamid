//
//  BaseOrderViewController.swift
//  topping app
//
//  Created by Hamidreza Zebardast on 12/14/24.
//

import UIKit

class BaseOrderViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var address: AddressModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = children.last as? UINavigationController,
        let vc = navigationController.visibleViewController as? OrderViewController {
            vc.receipt = ReceiptModel(address: address)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Invoice"
    }
}
