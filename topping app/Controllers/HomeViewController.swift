//
//  HomeViewController.swift
//  topping app
//
//  Created by Hamidreza Zebardast on 12/13/24.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var desriptionText: UILabel!
    var address: AddressModel?
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var state = State.shipFrom
    private var currentSelectionAddress = ""
    private var currentCoordinate = CLLocationCoordinate2D()
    private var isFindingAddress = false
    
    enum State {
        case shipFrom
        case shipTo
        
        var description: String {
            switch self {
            case .shipFrom:
                return "Ship From"
            case .shipTo:
                return "Ship To"
            }
        }
    }
    @IBAction func currentLocationButtonDidTouch(_ sender: UIButton) {
        showUserCurrentLocaionIfPossible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let name = UserManager.shared.activeUser?.fullName {
            navigationItem.title = "Good \(dayHourFormatter), \(name)"            
        } else {
            navigationItem.title = "Good \(dayHourFormatter), Google"
        }
        desriptionText.text = state.description
        mapView.delegate = self
        setupLocationManager()
        checkLocationauthorization()
        addMapTapGesture()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderNavigation",
           let address = address,
           let vc = segue.destination as? BaseOrderViewController {
            vc.address = address
            vc.hidesBottomBarWhenPushed = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
    }

    func showUserCurrentLocaionIfPossible() {
        if let location = locationManager.location {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func reset() {
        state = .shipFrom
        address = nil
        desriptionText.text = state.description
        mapView.annotations.forEach { mapView.removeAnnotation($0) }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func checkLocationauthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        showUserCurrentLocaionIfPossible()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationauthorization()
    }
}

extension HomeViewController: MKMapViewDelegate {
    func updateState() {
        switch state {
            case .shipTo:
            address?.shipToAddress = currentSelectionAddress
            address?.shipToCoordinates = currentCoordinate
            performSegue(withIdentifier: "OrderNavigation", sender: nil)
        case .shipFrom:
            address = AddressModel(
                shipFromAddress: currentSelectionAddress,
                shipFromCoordinates: currentCoordinate,
                shipToAddress: "",
                shipToCoordinates: CLLocationCoordinate2D()
            )
            self.state = .shipTo
        }
        desriptionText.text = state.description
    }
    
    func addMapTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapDidTapMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func mapDidTapMap(_ gesture: UITapGestureRecognizer) {
        guard !isFindingAddress else { return }
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        addAnnotaion(at: coordinate)
        getAddress(from: coordinate) { [weak self] address in
            self?.currentCoordinate = coordinate
            self?.currentSelectionAddress = address
            self?.updateState()
        }
    }
    
    func addAnnotaion(at coordinate: CLLocationCoordinate2D) {
        let marker = MKPointAnnotation()
        marker.title = state.description
        marker.coordinate = coordinate
        mapView.addAnnotation(marker)
    }
    
    func getAddress(from coordinate: CLLocationCoordinate2D, onCompletion completion: @escaping (String) -> Void) {
        isFindingAddress = true
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak self] placemarks, error in
            self?.isFindingAddress = false
            guard error == nil else {
                self?.reset()
                return
            }
            guard let placemark = placemarks?.first else { return }
            
        let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
            
            completion(address)
        }
    }
}

extension HomeViewController {
    var dayHourFormatter: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12: return "Morning"
        case 12: return "Noon"
        case 13..<17: return "Afternoon"
        case 17..<22: return "Evening"
        default: return "Night"
        }
    }
}
