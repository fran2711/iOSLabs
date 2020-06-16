//
//  ConnectionController.swift
//  iOSLabs
//
//  Created by Fran Lucena on 16/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ConnectionController {
    
    static let shared = ConnectionController()
    private init() {}
    
    public func getStations(onResult: @escaping(LabsApiResponse<AirportsList, AirportsStatusCode>) -> Void) {
        
        var airportsList = AirportsList()
        
        AF.request(Constants.stationsUrl, method: .get).responseString { (stationsResponse) in
            if let stationsValue = stationsResponse.value {
                let stationsJson = JSON(parseJSON: stationsValue)
                
                if stationsJson.exists() && !stationsJson.isEmpty {
                    
                    airportsList.airports = []
                    
                    if let airportsArray = stationsJson["stations"].array {
                        airportsArray.forEach { (airportData) in
                            do {
                                var airport = Airport()
                                let decoder = JSONDecoder()
                                airport = try decoder.decode(type(of: airport), from: airportData.rawData())
                                airportsList.airports?.append(airport)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        
                        onResult(LabsApiResponse.onSuccess(model:airportsList, requestStatus: .success, basicResponse: LabsBasicResponse(error: false)))
                        return
                    }
                }
            } else {
                onResult(LabsApiResponse.onError(model: airportsList, requestStatus: .failure, basicResponse: LabsBasicResponse(error: true)))
                return
            }
        }
    }
}
