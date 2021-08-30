//
//  DetailViewController.swift
//  YelpMVVm
//
//  Created by Dala  on 8/27/21.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    
    var model: Businesses?
    
    private var locationManager = CLLocationManager()
    private var location: CLLocation!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    
    var selectedImage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        loadLocationManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        imageView.image = selectedImage
        
        configureLabels()
        setupPhoneCalling()
        configureMapView()
    }
    
    func loadLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        navigateToLocation()
    }
    
    func configureLabels() {
        guard let rating = model?.rating,
              let address = model?.location?.address1,
              let distance =  model?.distance,
              let phone = model?.display_phone,
              let access = model?.is_closed else {
            return
        }
        
        let miles = distance * 0.00062137
        let convertedMiles = String(format: "%.2f", miles)
        
        nameLabel.text = model?.name ?? "N//A"
        distanceLabel.text = "Distance: \(String(describing: convertedMiles)) Mi."
        ratingLabel.text = "Rating: \(String(describing: rating))"
        addressLabel.text = "Address: \(address)"
        phoneNumber.text = "Phone: \(String(describing: phone))"
        accessLabel.text = access ? "Is Closed" : "Is Open"
    }
    
    func configureMapView() {
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 8
        mapView.isRotateEnabled = false
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            renderMapZoom(location)
        }
    }
    
    func renderMapZoom(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    func setupPhoneCalling() {
        phoneNumber.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(phoneNumberLabelTap))
        tap.delegate = self
        phoneNumber.addGestureRecognizer(tap)
    }
    
    @objc func phoneNumberLabelTap() {
        let myString = phoneNumber.text
        let outputStr = myString!.replacingOccurrences(of: "Phone Number:", with: "")
        let result = outputStr.filter("0123456789.".contains)
        let phoneCallURL = URL(string: "Tel://\(result)")
        UIApplication.shared.open(phoneCallURL! as URL, options: [:], completionHandler: nil)
    }
    
    func navigateToLocation() {
        guard model != nil, let address = model?.location?.appleMapsAddressString else {
            return
        }
        
        if let url = URL(string: "http://maps.apple.com/?address=\(address)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

public extension UIView {
    
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(duration: TimeInterval = 5.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
}
