//
//  ViewController.swift
//  YelpMVVm
//
//  Created by Dala  on 8/26/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

   var models = [Businesses]()
    
    var manager = CLLocationManager()
    var hasPermission: Bool?
    var currentLoc: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.frame = view.bounds
        
        checkForClientLocation()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
                         
        cell.accessLabel.text = models[indexPath.row].id
        cell.distanceLabel.text =  "\(String(describing: models[indexPath.row].distance))"
        cell.nameLabel.text = models[indexPath.row].name
        cell.ratingLabel.text = "\(String(describing: models[indexPath.row].rating))"
        cell.accessLabel.text = "\(models[indexPath.row].is_closed)"
        cell.imageView?.image = UIImage(systemName: "pencil")
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
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
            print(currentLoc?.coordinate.latitude)
            print(currentLoc?.coordinate.longitude)

        } else {
            print("Location access not granted")
        }

        APICaller.shared.fetchYelpBusinesses(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude) { [self] (result) in
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
