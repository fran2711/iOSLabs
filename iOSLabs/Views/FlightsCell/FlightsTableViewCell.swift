//
//  FlightsTableViewCell.swift
//  iOSLabs
//
//  Created by Fran Lucena on 19/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flightNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configureFlightsCell(flight: Flight?) {
        flightNameLabel.text = flight?.flightNumber
        
        if let amount = flight?.regularFare?.fares?.first?.amount {
            priceLabel.text = String(format: "%.2f", amount) + " €"
        }
        
        
        let dateFormatter = DateFormatter()

        var dateFormatedArray: [String] = []
        
        if let timeArray = flight?.timeUTC {
            
            timeArray.forEach { (date) in
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                if let formatedDate = dateFormatter.date(from: date) {
                    dateFormatter.dateFormat = "HH:mm"
                    dateFormatedArray.append(dateFormatter.string(from: formatedDate))
                }
            }
        }
        
        dateLabel.text = dateFormatedArray.joined(separator: " - ")
        
//        dateLabel.text = stringTime
        
        
        
        
        //        dateLabel.text = flight?.timeUTC
    }
    
}
