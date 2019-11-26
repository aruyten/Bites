//
//  FavoritesViewController.swift
//  Bites
//
//  Created by Adam Ruyten on 11/6/19.
//  Copyright © 2019 Adam Ruyten. All rights reserved.
//
import UIKit

class FavoritesViewController: UITableViewController{

	//sets number of rows equal to size of listoffavorites
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listOfFavorites.count
	}
	
	//fills cell with values in listoffavorites
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {		
		let cell = tableView.dequeueReusableCell(withIdentifier: "StuffCell", for: indexPath)
		cell.textLabel?.text = listOfFavorites[indexPath.item].0
		cell.detailTextLabel?.text = String(format: "%.2f", (listOfFavorites[indexPath.item].1) * 0.000621371192) +  " Miles"
		return cell
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	//allows for user to remove items from favorites list
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == UITableViewCell.EditingStyle.delete {
			listOfFavorites.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
		}
	}
}
