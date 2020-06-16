//
//  LabsApiResponse.swift
//  iOSLabs
//
//  Created by Fran Lucena on 16/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LabsApiResponse<T:Any, U:Any> {
    var hasError:Bool
    var model: T
    var basicResponse:LabsBasicResponse
    var error:Error?
    var requestSatus: U
    
    /*** STATIC METHODS ***/
    
    static func onSuccess (model: T, requestStatus: U,basicResponse: LabsBasicResponse) -> LabsApiResponse {
        return LabsApiResponse(model: model, hasError: false, requestStatus: requestStatus, basicResponse: basicResponse)
    }
    
    
    static func onError  (model: T, requestStatus: U, basicResponse: LabsBasicResponse) -> LabsApiResponse {
        return  LabsApiResponse(model: model, hasError: true, requestStatus: requestStatus, basicResponse: basicResponse)
    }
    
    static func onError  (model: T, requestStatus: U, basicResponse: LabsBasicResponse, error: Error) -> LabsApiResponse {
        return  LabsApiResponse(model: model, hasError: true, requestStatus: requestStatus, basicResponse: basicResponse, error: error)
    }
    
    
    
    /*** INITIALIZERS ***/
    
    init (model:T, hasError:Bool, requestStatus: U, basicResponse:LabsBasicResponse) {
        self.model = model
        self.hasError = hasError
        self.requestSatus = requestStatus
        self.basicResponse = basicResponse
    }
    
    convenience init (model:T, hasError:Bool, requestStatus: U, basicResponse:LabsBasicResponse, error:Error) {
        self.init(model: model, hasError: hasError, requestStatus: requestStatus, basicResponse: basicResponse)
        self.error = error
    }
    
}
