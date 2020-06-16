//
//  LabsBasicResponse.swift
//  iOSLabs
//
//  Created by Fran Lucena on 16/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import Foundation

class LabsBasicResponse {
    
    /*** VAR ***/
    var status:Int = 200
    var code:String = ""
    var rawResponse: String =  ""
    
    /*** INITS ***/
    
    init (error: Bool) {
        if (error) {
            code = "INTERNAL_ERROR"
            status = 404
        }
    }    
}
