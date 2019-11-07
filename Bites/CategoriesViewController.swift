//
//  CategoriesViewController.swift
//  Bites
//
//  Created by Adam Ruyten on 11/6/19.
//  Copyright © 2019 Adam Ruyten. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

class CategoriesViewController: UIViewController{
	
	//list of restaurants from search
	var MexicanList: [String] = []
	var PizzaList: [String] = []
	var ChineseList: [String] = []
	
	var sendingList: [String] = []
	
	//create location manager
	let locationManager = CLLocationManager()
	
	//category button outlets
	@IBOutlet weak var MexicanButton: UIButton!
	@IBOutlet weak var PizzaButton: UIButton!
	@IBOutlet weak var ChineseButton: UIButton!
	
	
	
	
	
	@IBAction func PressMexicanButton(_ sender: UIButton) {
		sendingList = MexicanList
	}
	
	@IBAction func PressPizzaButton(_ sender: Any) {
		sendingList = PizzaList
	}
	
	@IBAction func PressChineseButton(_ sender: UIButton) {
		sendingList = ChineseList
	}
	
	
	
	
	
	
	
	//only transitions to results if location services are permitted
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		//allows seque when location permissions are enabled
		if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
			return true
		}
		//otherwise it alerts the user that they need location permissions
		else {
			let alert = UIAlertController(title: "Location Required", message: "This is app requires access to this devices location to function ", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
			self.present(alert, animated: true, completion: nil)
			return false
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is ResultsViewController{
			let vc = segue.destination as? ResultsViewController
			vc?.sentList = sendingList
		}
	}
	
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.delegate = self
		if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || 	CLLocationManager.authorizationStatus() == .authorizedAlways){
			locationManager.requestLocation()
		}
		else{
			print("App does not yet have permission to access location")
			locationManager.requestWhenInUseAuthorization()
		}
	}
	
	
	
	func SearchForMexicanFood(){
		let request = MKLocalSearch.Request()
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.naturalLanguageQuery = "Mexican"
		request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
		
		let search = MKLocalSearch(request: request)
		search.start(completionHandler: {(response, error) in for item in response!.mapItems {
			self.MexicanList.append(item.name!)}})
	}
	
	func SearchForPizzaFood(){
		let request = MKLocalSearch.Request()
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.naturalLanguageQuery = "Pizza"
		request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
		
		let search = MKLocalSearch(request: request)
		search.start(completionHandler: {(response, error) in for item in response!.mapItems {
			self.PizzaList.append(item.name!)}})
	}
	
	func SearchForChineseFood(){
		let request = MKLocalSearch.Request()
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.naturalLanguageQuery = "Chinese"
		request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
		
		let search = MKLocalSearch(request: request)
		search.start(completionHandler: {(response, error) in for item in response!.mapItems {
			self.ChineseList.append(item.name!)}})
	}
	
}
extension CategoriesViewController: CLLocationManagerDelegate{
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("error")
	}

	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("permissions for location manager changed")
		if (status == .authorizedWhenInUse || status == .authorizedAlways){
			manager.requestLocation()
		}
    }
	
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print(manager.location!)
		SearchForMexicanFood()
		SearchForPizzaFood()
		SearchForChineseFood()
		//print(MexicanList)
    }
}
