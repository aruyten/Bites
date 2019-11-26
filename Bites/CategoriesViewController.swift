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
import CoreGraphics

class CategoriesViewController: UIViewController{
    
    
    
	//list of restaurants from search
	var MexicanList: [(String, CLLocationDistance)] = []
	var PizzaList: [(String, CLLocationDistance)]  = []
	var ChineseList: [(String, CLLocationDistance)]  = []
	
    //List that is passed to results view
    var sendingList: [(String, CLLocationDistance)]  = []
	
    //create location manager
	let locationManager = CLLocationManager()

	
	//category button outlets
	@IBOutlet weak var MexicanButton: UIButton!
	@IBOutlet weak var PizzaButton: UIButton!
	@IBOutlet weak var ChineseButton: UIButton!
	
	
	//category button actions
	@IBAction func PressMexicanButton(_ sender: UIButton) {
		MexicanList.sort{if ($0.1 != $1.1){return ($0.1 < $1.1)} else{return $0.0 < $1.0}}
		sendingList = MexicanList
	}
	
	@IBAction func PressPizzaButton(_ sender: Any) {
		PizzaList.sort{if ($0.1 != $1.1){return ($0.1 < $1.1)} else{return $0.0 < $1.0}}
		sendingList = PizzaList
	}
	
	@IBAction func PressChineseButton(_ sender: UIButton) {
		ChineseList.sort{if ($0.1 != $1.1){return ($0.1 < $1.1)} else{return $0.0 < $1.0}}
		sendingList = ChineseList
	}
    
	
	//only transitions to results if location services are permitted
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		//allows seque when location permissions are enabled
		if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
			CLLocationManager.authorizationStatus() == .authorizedAlways){
			return true
		}
			
		//otherwise it alerts the user that they need location permissions
		else {
			let alert = UIAlertController(title: "Location Required", message: "This app requires access to your device's location to function ", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
			self.present(alert, animated: true, completion: nil)
			return false
		}
	}
	
    
    //sends data to results VC
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is ResultsViewController{
			let vc = segue.destination as? ResultsViewController
			vc?.sentList = sendingList
		}
	}
    
	
	override func viewDidLoad() {
		super.viewDidLoad()

		//sets backround as a gradient color
        let layer = CAGradientLayer()
		layer.frame = CGRect(x: view.safeAreaLayoutGuide.layoutFrame.minX,
							 y: view.safeAreaLayoutGuide.layoutFrame.minY,
							 width: view.safeAreaLayoutGuide.layoutFrame.maxX,
							 height: view.safeAreaLayoutGuide.layoutFrame.maxY)
		layer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
		layer.startPoint = CGPoint(x: 0.4, y: 0.4)
		layer.endPoint = CGPoint(x: 0.7, y: 0.8)
        view.layer.insertSublayer(layer, at: 0)
	
		//formats buttons to have rounded corners
		MexicanButton.layer.cornerRadius =  15
		PizzaButton.layer.cornerRadius = 15
		ChineseButton.layer.cornerRadius = 15
		
		
		locationManager.delegate = self
		
		//makes sure to request location permissions if not already allowed
		if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || 	CLLocationManager.authorizationStatus() == .authorizedAlways){
			locationManager.requestLocation()
		}
		else{
			print("App does not yet have permission to access location")
			locationManager.requestWhenInUseAuthorization()
		}
	}

	
	
	
	
    //food search functions
	func SearchForMexicanFood(){
		MexicanList.removeAll()
		
		let request = MKLocalSearch.Request()
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.naturalLanguageQuery = "Mexican"
		request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
		
		let search = MKLocalSearch(request: request)
		search.start(completionHandler: {(response, error) in for item in response!.mapItems {
			let location = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
			let distance = self.locationManager.location!.distance(from: location)
			self.MexicanList.append((item.name!, distance))}})
    }

	
	func SearchForPizzaFood(){
		PizzaList.removeAll()
		let request = MKLocalSearch.Request()
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.naturalLanguageQuery = "Pizza"
		request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
		
		let search = MKLocalSearch(request: request)
		search.start(completionHandler: {(response, error) in for item in response!.mapItems {
			let location = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
			let distance = self.locationManager.location!.distance(from: location)
			self.PizzaList.append((item.name!, distance))}})
	}
	
	func SearchForChineseFood(){
		ChineseList.removeAll()
		let request = MKLocalSearch.Request()
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.naturalLanguageQuery = "Chinese"
		request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
		
		let search = MKLocalSearch(request: request)
		search.start(completionHandler: {(response, error) in for item in response!.mapItems {
			let location = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
			let distance = self.locationManager.location!.distance(from: location)
			self.ChineseList.append((item.name!, distance))}})
	}
	
	func ClearResults(){
		MexicanList = []
		PizzaList = []
		ChineseList = []
	}
}


//override of default fucntions for location manager delegate
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
		ClearResults()
		SearchForMexicanFood()
		SearchForPizzaFood()
		SearchForChineseFood()
    }
}
