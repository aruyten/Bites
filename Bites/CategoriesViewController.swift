//
//  CategoriesViewController.swift
//  Bites
//
//  Created by Adam Ruyten on 11/6/19.
//  Copyright © 2019 Adam Ruyten. All rights reserved.
//
import UIKit
import CoreLocation

class CategoriesViewController: UIViewController{
	
	
	//create default location
	let locationManager = CLLocationManager()
	var currentLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
	var latitudeLabel: Double = 0.0
	var longitudeLabel: Double = 0.0
	//category button outlets
	@IBOutlet weak var MexicanButton: UIButton!
	@IBOutlet weak var PizzaButton: UIButton!
	@IBOutlet weak var ChineseButton: UIButton!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		
		if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
			locationManager.requestLocation()
			print(String(describing: locationManager.location))
		}
		else{
			print("App does not have permission to access location")
		}
		

	}
}

extension CategoriesViewController: CLLocationManagerDelegate {
  // handle delegate methods of location manager here
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

		print("location error is = \(error.localizedDescription)")

	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
    }
	
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            self.latitudeLabel = location.coordinate.latitude
            self.longitudeLabel = location.coordinate.longitude
        }
    }
}
