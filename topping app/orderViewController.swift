
import UIKit
import MapKit

class OrderViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "topping"))
        imageView.frame = CGRect(x: 0, y: 100, width: 400, height: 200)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)

        let maskLayer = CAShapeLayer()
               let path = UIBezierPath()

               // ایجاد مسیر برای قوس در پایین
               path.move(to: CGPoint(x: 0, y: 0))
               path.addLine(to: CGPoint(x: imageView.bounds.width, y: 0))
               path.addLine(to: CGPoint(x: imageView.bounds.width, y: imageView.bounds.height - 50)) // خط عمودی سمت راست
               path.addQuadCurve(to: CGPoint(x: 0, y: imageView.bounds.height - 50), controlPoint: CGPoint(x: imageView.bounds.width / 2, y: imageView.bounds.height)) // قوس در پایین
               path.close()

               maskLayer.path = path.cgPath
               imageView.layer.mask = maskLayer
        let mapTextField = UITextField()
              mapTextField.frame = CGRect(x: 20, y: imageView.frame.maxY + 20, width: 360, height: 45)
              mapTextField.borderStyle = .roundedRect
              mapTextField.placeholder = "Where is your pakage going?"
              mapTextField.delegate = self
              view.addSubview(mapTextField)
              
              // افزودن UITextField با ارتفاع ۴۵
              let regularTextField = UITextField()
              regularTextField.frame = CGRect(x: 20, y: mapTextField.frame.maxY + 20, width: 360, height: 45)
              regularTextField.borderStyle = .roundedRect
              regularTextField.placeholder = "Enter text here"
              view.addSubview(regularTextField)
          }
          
          // متد delegate که وقتی کاربر بر روی UITextField کلیک کند اجرا می‌شود
          func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
              if textField.placeholder == "Where is your pakage going?" {
                  openMap()
                  return false // جلوگیری از نمایش کیبورد
              }
              return true // اجازه می‌دهد کیبورد نمایش داده شود برای دیگر UITextField
          }
          
          // تابعی برای باز کردن نقشه
          func openMap() {
              let coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // مختصات دلخواه، مثلاً سانفرانسیسکو
              
              let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
              mapItem.name = "San Francisco"
              
              let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
              mapItem.openInMaps(launchOptions: launchOptions)
          }
      }


