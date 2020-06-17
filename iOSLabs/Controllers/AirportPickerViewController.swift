//
//  AirportPickerViewController.swift
//  iOSLabs
//
//  Created by Fran Lucena on 17/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

protocol AirportPickerViewControllerDelegate {
    func selectedAirport(airport: Airport?, isOriginAirport: Bool)
}

class AirportPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var airportPickerBackgroundView: UIView!
    @IBOutlet weak var aiportPickerView: UIPickerView!
    
    var delegate: AirportPickerViewControllerDelegate?
    var isOriginAirport = false
    
    var airportList: AirportsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let airports = airportList?.airports else {
            return 0
        }
        return airports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return airportList?.airports?[row].name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dismiss(animated: true, completion: nil)
        delegate?.selectedAirport(airport: airportList?.airports?[row], isOriginAirport: isOriginAirport)
    }
    
}
