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

	var sentList: [(String, CLLocationDistance)] = []
	

	
	@IBOutlet var ResultsTable: UITableView!
	@IBOutlet weak var DistanceCell: UILabel!
	@IBOutlet weak var NameCell: UILabel!
	
	override func viewDidLoad() {

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
}

class StuffCell: UITableViewCell{
	@IBOutlet weak var DistanceCell: UILabel!

}
