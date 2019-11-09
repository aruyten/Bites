//
//  FavoritesViewController.swift
//  Bites
//
//  Created by Adam Ruyten on 11/6/19.
//  Copyright © 2019 Adam Ruyten. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController{
	

	
	override func viewDidLoad() {
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listOfFavorites.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {		
		let cell = tableView.dequeueReusableCell(withIdentifier: "StuffCell", for: indexPath)
		cell.textLabel?.text = listOfFavorites[indexPath.item]
		return cell
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
}
