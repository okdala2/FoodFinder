//
//  ViewController.swift
//  YelpMVVm
//
//  Created by Dala  on 8/26/21.
//

import UIKit
import CoreLocation
import Alamofire
import MapKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private let hoverButton = HoverButton()
    var models = [Businesses]()
    var category: Category?
    
    private var manager = CLLocationManager()
    private var hasPermission: Bool?
    private var locationManager: CLLocationManager!
    private var currentLoc: CLLocation!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForClientLocation()
        setupTableViewDelegates()
        addHoverButton()
    }
    
    override func viewDidLayoutSubviews() {
        hoverButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 100, width: 60, height: 60)
        hoverButton.addTarget(self, action: #selector(openYelpSupport), for: .touchUpInside)
    }
    
    func setupTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        let miles = models[indexPath.row].distance * 0.00062137
        let convertedMiles = String(format: "%.2f", miles)
        
        cell.distanceLabel.text = "Distance: \(String(describing: convertedMiles)) Mi."
        cell.nameLabel.text = "\(models[indexPath.row].name)"
        cell.ratingLabel.text = "Rating: \(String(describing: models[indexPath.row].rating))"
        cell.accessLabel.text = "Status: \(String(describing: models[indexPath.row].is_closed ?? true ? "Is Closed" : "Is Open"))"
        
        if let imageURL = URL(string: models[indexPath.row].image_url), let placeholder = UIImage(named: "bowl") {
            cell.imageView?.clipsToBounds = true
            cell.imageView?.af_setImage(withURL: imageURL, placeholderImage: placeholder)
            cell.setNeedsLayout()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            vc.selectedImage = cell.imageView?.image
            vc.model = models[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func addHoverButton() {
        view.addSubview(hoverButton)
        view.bringSubviewToFront(hoverButton)
    }
    
    @objc func openYelpSupport() {
        guard let url = URL(string: "https://www.yelp-support.com/?l=en_US") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func sortBasedOnSegmentPressed() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            models.sort(by: {$0.distance < $1.distance})
        case 1:
            models.sort(by: {$0.rating < $1.rating})
        case 2:
            models.sort(by: {$0.review_count < $1.review_count})
            
        default:
            print("Something happened")
        }
        self.tableView.reloadData()
    }
    
    @IBAction func sortSegmentedPressed(_ sender: Any) {
        sortBasedOnSegmentPressed()
    }
    
    func checkForClientLocation() {
        switch manager.authorizationStatus {
        case .restricted, .denied:
            hasPermission = false
        default:
            hasPermission = true
        }
        
        manager.requestWhenInUseAuthorization()
        currentLoc = manager.location
        
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            currentLoc = manager.location
            fetchData()
        } else {
            showSettings()
        }
    }
    
    func showSettings() {
        let alertController = UIAlertController (title: "Hi! Turn on location for us to work with you :)", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func fetchData() {
        APICaller.shared.fetchYelpBusinesses(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude) { (result) in
            switch result {
            
            case .success(let response):
                self.models = response
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(.invalidCall):
                print("Invalid Call")
            case .failure(.invalidData):
                print("Invalid Data")
            }
        }
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLoc = locations.last ?? CLLocation()
        sortBasedOnSegmentPressed()
    }
}
