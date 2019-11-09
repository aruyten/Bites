//
//  ResultsViewController.swift
//  Bites
//
//  Created by Adam Ruyten on 11/6/19.
//  Copyright © 2019 Adam Ruyten. All rights reserved.
//

import UIKit
import MapKit

var listOfFavorites: [String] = []


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

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sentList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StuffCell", for: indexPath)
		cell.textLabel?.text = sentList[indexPath.item].0
		//String(format: "%.1f", convertedValue)
		cell.detailTextLabel?.text = String(format: "%.2f", sentList[indexPath.item].1) +  " Meters"
		return cell
	}

	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	

	override func tableView(_ tableView: UITableView,
		trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
		let favoriteAction = UIContextualAction(style: .normal, title:  "Favorite", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
			print("Update action ...")
			self.addToFavorites(location: self.sentList[indexPath.item].0)
			success(true)})
		   favoriteAction.backgroundColor = .orange
		   return UISwipeActionsConfiguration(actions: [favoriteAction])
	   }

	func addToFavorites(location: String){
		listOfFavorites.append(location)
		favVC?.tableView.reloadData()
	}

}

class StuffCell: UITableViewCell{
	@IBOutlet weak var DistanceCell: UILabel!

}
