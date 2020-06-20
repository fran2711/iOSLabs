//
//  SearchAirportsViewController.swift
//  iOSLabs
//
//  Created by Fran Lucena on 20/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

protocol SearchAirportsViewControllerDelegate {
    func selectedAirport(airport: Airport?, isOriginAirport: Bool)
}

class SearchAirportsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
   
    
    @IBOutlet weak var airportsTableView: UITableView!
    
    var isOriginAirport = false
    var airportList: AirportsList?
    var searchDelegate: SearchAirportsViewControllerDelegate?
    var cellId = "AirportCellId"
    var searchController = UISearchController(searchResultsController: nil)
    
    var filteredAirports = [Airport]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airportsTableView.register(UINib(nibName: "AirportTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        airportsTableView.tableHeaderView = searchController.searchBar

    }
    
    // MARK: - TabelView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredAirports.count
        } else if let airports = airportList?.airports {
            return airports.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AirportTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AirportTableViewCell else {
            return UITableViewCell()
        }
        
        var airportsList = AirportsList()

        if searchController.isActive && searchController.searchBar.text != "" {
            airportsList.airports = filteredAirports
        } else {
            airportsList = self.airportList ?? AirportsList()
        }
        
        cell.configureAirportCell(airport: airportsList.airports?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            searchDelegate?.selectedAirport(airport: filteredAirports[indexPath.row], isOriginAirport: self.isOriginAirport)
            self.presentingViewController?.dismiss(animated: true, completion: nil)

        } else {
            
            searchDelegate?.selectedAirport(airport: airportList?.airports?[indexPath.row], isOriginAirport: self.isOriginAirport)
            self.dismiss(animated: true, completion: nil)
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterAirports(for: searchController.searchBar.text ?? "")
    }
    
    func filterAirports(for searchText: String) {

        if let airports = airportList?.airports {
            filteredAirports = airports.filter({ airport in
                if let airportName = airport.name?.lowercased() {
                    return (airportName.contains(searchText.lowercased()))
                } else {
                    return false
                }
            })
        }
        
        airportsTableView.reloadData()
    }
}
