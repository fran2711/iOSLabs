//
//  FlightsListViewController.swift
//  iOSLabs
//
//  Created by Fran Lucena on 18/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

class FlightsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var flightsTableView: UITableView!
    
    var fligths: Flights?
    var cellId = "FlightsCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flightsTableView.register(UINib(nibName: "FlightsTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fligths?.trips?.first?.dates?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fligths?.trips?.first?.dates?[section].flights?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()

        let sectionLabel = UILabel(frame: CGRect(x: 8, y: 10, width:
        tableView.bounds.size.width, height: 60))
        
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        if let dateOut = fligths?.trips?.first?.dates?[section].dateOut, let formatedDate = dateFormatter.date(from: dateOut) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            sectionLabel.text = dateFormatter.string(from: formatedDate)
        }
        
//        sectionLabel.text = fligths?.trips?.first?.dates?[section].dateOut
        sectionLabel.textColor = .white
        
        headerView.backgroundColor = .systemBlue
        
        sectionLabel.sizeToFit()
        headerView.addSubview(sectionLabel)
        
         return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: FlightsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? FlightsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureFlightsCell(flight: fligths?.trips?.first?.dates?[indexPath.section].flights?[indexPath.row])
        
        return cell
    }

}
