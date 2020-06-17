//
//  SearchFlightsViewController+UITextField.swift
//  iOSLabs
//
//  Created by Fran Lucena on 17/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import Foundation
import UIKit

extension SearchFlightsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == adultsTextField {
            teensTextField.becomeFirstResponder()
        } else if textField == teensTextField {
            childsTextField.becomeFirstResponder()
        } else if textField == childsTextField {
            childsTextField.resignFirstResponder()
        }
        return true
    }
    
    
    
}
