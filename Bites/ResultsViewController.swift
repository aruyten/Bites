//
//  ResultsViewController.swift
//  Bites
//
//  Created by Adam Ruyten on 11/6/19.
//  Copyright © 2019 Adam Ruyten. All rights reserved.
//

import UIKit
import MapKit


class ResultsViewController: UITableViewController{
	
	
	
	
	
	@IBOutlet var ResultsTable: UITableView!
	
	let testArray = ["Pizza by Alfredo", "Alfredo's Pizza Cafe", "JJ's Diner"]
	
	
	override func viewDidLoad() {
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return testArray.capacity
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "StuffCell", for: indexPath)
		cell.textLabel?.text = "\(testArray[indexPath.row])"
		return cell
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}



}
