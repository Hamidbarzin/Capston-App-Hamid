//
//  orderViewViewController.swift
//  topping app
//
//  Created by Hamidreza Zebardast on 2024-09-11.
//

import UIKit

class orderView: UIView {
    
    func createTextField(withWidth width: CGFloat, height: CGFloat) -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: width, height: height)
        textField.borderStyle = .roundedRect // تنظیم ظاهر و سایر ویژگی‌ها در صورت نیاز
        return textField
    }

   

}
