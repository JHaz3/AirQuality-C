//
//  StatesListViewController.swift
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StatesListViewController: UIViewController {
    //MARK: - Properties
    var country: String?
    var states: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let country = country else { return }
        HAZCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            if let states = states {
                self.states = states
            }
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesListVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let country = country,
                let destinationVC = segue.destination as? CitiesListViewController
                else { return }
            let selectedState = states[indexPath.row]
            destinationVC.country = country
            destinationVC.state = selectedState
        }
    }
    
    //MARK: - Class Methods
    // this is a property observer
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}// End of Class

extension StatesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
}
