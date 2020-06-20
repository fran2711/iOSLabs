//
//  PassengersPickerViewController.swift
//  iOSLabs
//
//  Created by Fran Lucena on 20/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

protocol PassengersPickerViewControllerDelegate {
    func selectedNumberOfPassengers(passengers: Int?, isAdult: Bool, isTeen: Bool)
}


class PassengersPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var passengersPickerView: UIPickerView!
    
    var numberOfAdultPassengers = [1, 2, 3, 4, 5, 6]
    var numberOfPassengers = [0, 1, 2, 3, 4, 5, 6]
    var selectedNumberOfPassengers: Int?
    var isAdult = false
    var isTeen = false
    
    var passengersDelegate: PassengersPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var rowsCount = 0
        
        if isAdult {
            rowsCount = numberOfAdultPassengers.count
        } else {
            rowsCount = numberOfPassengers.count
        }
        
        return rowsCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var text = ""
        
        if isAdult {
            text = String(describing: numberOfAdultPassengers[row])
        } else {
            text = String(describing: numberOfPassengers[row])
        }
        
        return text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isAdult {
            selectedNumberOfPassengers = numberOfAdultPassengers[row]
        } else if isTeen {
            selectedNumberOfPassengers = numberOfPassengers[row]
        } else {
            selectedNumberOfPassengers = numberOfPassengers[row]
        }
        
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        if selectedNumberOfPassengers == nil && isAdult {
            passengersDelegate?.selectedNumberOfPassengers(passengers: numberOfAdultPassengers[0], isAdult: isAdult, isTeen: isTeen)
        } else if selectedNumberOfPassengers == nil && isTeen {
            passengersDelegate?.selectedNumberOfPassengers(passengers: numberOfPassengers[0], isAdult: isAdult, isTeen: isTeen)
        } else if selectedNumberOfPassengers == nil {
            passengersDelegate?.selectedNumberOfPassengers(passengers: numberOfPassengers[0], isAdult: isAdult, isTeen: isTeen)
        } else {
            passengersDelegate?.selectedNumberOfPassengers(passengers: selectedNumberOfPassengers, isAdult: isAdult, isTeen: isTeen)

        }
        dismiss(animated: true, completion: nil)
    }
}
