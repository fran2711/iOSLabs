//
//  SearchFlightsViewController.swift
//  iOSLabs
//
//  Created by Fran Lucena on 17/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import UIKit

class SearchFlightsViewController: UIViewController, SearchAirportsViewControllerDelegate, DatePickerViewControllerDelegate, PassengersPickerViewControllerDelegate {
    
    
    
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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var airportList: AirportsList?
    var origingAirport: String?
    var destinationAirport: String?
    
    var flights: Flights?
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToFlightsView" {
            guard let flightsVC: FlightsListViewController = segue.destination as? FlightsListViewController else {
                return
            }
            flightsVC.fligths = self.flights
        }
    }
    
    
    // MARK: - Action
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        var childs: String = "0"
        var teens: String = "0"
        
        if let destinationCode = destinationAirport, let originCode = origingAirport, let date = selectedDateLabel.text, let adults = adultsTextField.text {
            
            if let childsText = childsTextField.text, !childsText.isEmpty {
                childs = childsText
            }
            
            if let teensText = teensTextField.text, !teensText.isEmpty {
                teens = teensText
            }
            
            if destinationCode.isEmpty || originCode.isEmpty || adults.isEmpty || date.isEmpty {
                let alert = UIAlertController(title: "Error", message: "Origin, destination, date or adults can't be empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.getFlights(origin: originCode, destination: destinationCode, date: date, adults: adults, childs: childs, teens: teens)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Origin, destination, date or adults can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func adultsButtonAction(_ sender: Any) {
        showPassengersPicker(isAdult: true, isTeen: false)
    }
    
    
    @IBAction func teensButtonAction(_ sender: Any) {
        showPassengersPicker(isAdult: false, isTeen: true)
    }
    
    
    @IBAction func childsButtonAction(_ sender: Any) {
        showPassengersPicker(isAdult: false, isTeen: false)
    }
    
    // MARK: - Tap Gestures
    
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
    
    
    // MARK: - Internal
    
    func getAirports(isOriginAirport: Bool) {
        ConnectionController.shared.getStations() { (response) in
            if !response.hasError {
                self.airportList = response.model
                self.showAirportSelection(isOriginAirport: isOriginAirport)
            }
        }
    }
    
    func getFlights(origin: String, destination: String, date: String, adults: String, childs: String, teens: String) {
        activityIndicator.startAnimating()
        ConnectionController.shared.getFlights(originCode: origin, destinationCode: destination, dateOut: date, adt: adults, teen: teens, chd: childs) { (response) in
            if !response.hasError {
                self.flights = response.model
                self.performSegue(withIdentifier: "SearchToFlightsView", sender: self)
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Show Methods
    
    func showPassengersPicker(isAdult: Bool, isTeen: Bool) {
        
        let storyboard = UIStoryboard(name: "PassengersPickerView", bundle: nil)
        guard let alertVC: PassengersPickerViewController = storyboard.instantiateInitialViewController() as? PassengersPickerViewController else {
            return
        }
        
        alertVC.isAdult = isAdult
        alertVC.isTeen = isTeen
        alertVC.passengersDelegate = self
        showAlertController(alertViewController: alertVC)
    }
    
    func showAirportSelection(isOriginAirport: Bool) {
        
        let storyboard = UIStoryboard(name: "SearchAiport", bundle: nil)
        guard let alertViewController: SearchAirportsViewController = storyboard.instantiateInitialViewController() as? SearchAirportsViewController else {
            return
        }
        
        alertViewController.isOriginAirport = isOriginAirport
        alertViewController.searchDelegate = self
        alertViewController.airportList = self.airportList
        showAlertController(alertViewController: alertViewController)
    }
    
    func showAlertController(alertViewController: UIViewController) {
        alertViewController.providesPresentationContextTransitionStyle = true
        alertViewController.definesPresentationContext = true
        alertViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    
    // MARK: - Delegate Methods
    
    func selectedAirport(airport: Airport?, isOriginAirport: Bool) {
        if isOriginAirport {
            originAirportLabel.text = airport?.name
            self.origingAirport = airport?.code
            originAirportLabel.textColor = .black
        } else {
            destinationAirportLabel.text = airport?.name
            self.destinationAirport = airport?.code
            destinationAirportLabel.textColor = .black
        }
    }
    
    func selectedDate(date: String) {
        selectedDateLabel.text = date
    }
    
    func selectedNumberOfPassengers(passengers: Int?, isAdult: Bool, isTeen: Bool) {
        
        if let pass = passengers {
            
            if isAdult {
                self.adultsTextField.text = String(describing: pass)
            } else if isTeen {
                self.teensTextField.text = String(describing: pass)
            } else {
                self.childsTextField.text = String(describing: pass)
            }
        }
    }
    
    
}
