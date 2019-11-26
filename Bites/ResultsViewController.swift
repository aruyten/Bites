//
//  ResultsViewController.swift
//  Bites
//
//  Created by Adam Ruyten on 11/6/19.
//  Copyright © 2019 Adam Ruyten. All rights reserved.
//

import UIKit
import MapKit

//allows global access to listOfFavorites
var listOfFavorites: [(String, CLLocationDistance)] = []


class ResultsViewController: UITableViewController{

	var favVC: FavoritesViewController?
	
	var sentList: [(String, CLLocationDistance)] = []
	
	@IBOutlet var ResultsTable: UITableView!
	@IBOutlet weak var DistanceCell: UILabel!
	@IBOutlet weak var NameCell: UILabel!
	
	override func viewDidLoad() {
		if let fav = tabBarController?.viewControllers![1] {
			favVC = (fav as! FavoritesViewController)
		}
	}

	//sets number of rows equal to sent list
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sentList.count
	}
	
	//fills rows with name and distance
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StuffCell", for: indexPath)
		cell.textLabel?.text = sentList[indexPath.item].0
		
		//converts to a 2 decimal float and also converts meters into miles
		cell.detailTextLabel?.text = String(format: "%.2f", (sentList[indexPath.item].1) * 0.000621371192) +  " Miles"
		return cell
	}

	//number of sections is 1
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	

	//allows for left swipe to allow adding row to favorites
	override func tableView(_ tableView: UITableView,
		trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
		let favoriteAction = UIContextualAction(style: .normal, title:  "Favorite", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
				print("Update action ...")
				self.addToFavorites(location: self.sentList[indexPath.item])
				listOfFavorites.sort{if ($0.1 != $1.1){return ($0.1 < $1.1)} else{return $0.0 < $1.0}}
			success(true)})
		
		   favoriteAction.backgroundColor = .orange
		   return UISwipeActionsConfiguration(actions: [favoriteAction])
	   }

	
	func addToFavorites(location: (String, CLLocationDistance)){
		listOfFavorites.append(location)
		favVC?.tableView.reloadData()
	}

}


//class to help with formatting of cells
class StuffCell: UITableViewCell{
	@IBOutlet weak var DistanceCell: UILabel!
}
