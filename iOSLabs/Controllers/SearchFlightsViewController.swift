//
//  SearchFlightsViewController.swift
//  iOSLabs
//
//  Created by Fran Lucena on 17/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

class SearchFlightsViewController: UIViewController, AirportPickerViewControllerDelegate, DatePickerViewControllerDelegate {

    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var originAirportLabel: UILabel!
    @IBOutlet weak var destinationAirportLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var teensLabel: NSLayoutConstraint!
    @IBOutlet weak var childLabel: UILabel!
    @IBOutlet weak var adultsTextField: UITextField!
    @IBOutlet weak var teensTextField: UITextField!
    @IBOutlet weak var childsTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    var airportList: AirportsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originAirportLabel.isUserInteractionEnabled = true
        destinationAirportLabel.isUserInteractionEnabled = true
        selectedDateLabel.isUserInteractionEnabled = true
        
        let originTap = UITapGestureRecognizer(target: self, action: #selector(getOriginAirports(_:)))
        originAirportLabel.addGestureRecognizer(originTap)
        
        let destinationTap = UITapGestureRecognizer(target: self, action: #selector(getDestinationAirports(_:)))
        destinationAirportLabel.addGestureRecognizer(destinationTap)
        
        let dateTap = UITapGestureRecognizer(target: self, action: #selector(getDate(_:)))
        selectedDateLabel.addGestureRecognizer(dateTap)
        
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
    }
    
    
    
    @objc func getOriginAirports(_ sender: UITapGestureRecognizer) {
        getAirports(isOriginAirport: true)
    }
    
    @objc func getDestinationAirports(_ sender: UITapGestureRecognizer) {
        getAirports(isOriginAirport: false)
    }
    
    @objc func getDate(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "DatePickerView", bundle: nil)
        guard let alertViewController: DatePickerViewController = storyboard.instantiateInitialViewController() as? DatePickerViewController else {
            return
        }
        
        alertViewController.delegate = self
        showAlertController(alertViewController: alertViewController)
    }
    
    func getAirports(isOriginAirport: Bool) {
        ConnectionController.shared.getStations() { (response) in
            if !response.hasError {
                self.airportList = response.model
                self.showAirportSelection(isOriginAirport: isOriginAirport)
            }
        }
    }
    
    func showAirportSelection(isOriginAirport: Bool) {
        let storyboard = UIStoryboard(name: "AirportPickerView", bundle: nil)
        guard let alertViewController: AirportPickerViewController = storyboard.instantiateInitialViewController() as? AirportPickerViewController else {
            return
        }
        alertViewController.isOriginAirport = isOriginAirport
        alertViewController.delegate = self
        alertViewController.airportList = self.airportList
        showAlertController(alertViewController: alertViewController)
    }
    
    func selectedAirport(airport: Airport?, isOriginAirport: Bool) {
        if isOriginAirport {
            originAirportLabel.text = airport?.name
            originAirportLabel.textColor = .black
        } else {
            destinationAirportLabel.text = airport?.name
            destinationAirportLabel.textColor = .black
        }
    }
    
    func selectedDate(date: String) {
        selectedDateLabel.text = date
    }
    
    
    
    func showAlertController(alertViewController: UIViewController) {
        alertViewController.providesPresentationContextTransitionStyle = true
        alertViewController.definesPresentationContext = true
        alertViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
}
