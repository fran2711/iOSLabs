//
//  AirportTableViewCell.swift
//  iOSLabs
//
//  Created by Fran Lucena on 20/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var airportNameLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureAirportCell(airport: Airport?) {
        airportNameLabel.text = airport?.name
    }
    
}
