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
    
    
    public func getFlights(originCode: String, destinationCode: String, dateOut: String, adt: String, teen: String, chd: String, onResult: @escaping(LabsApiResponse<Flights, FlightsStatusCode>) -> Void) {
        var flights = Flights()
        
        let parameters: [String: String] = ["origin" : originCode,
                                      "destination": destinationCode,
                                      "dateOut": dateOut,
                                      "dateIn" : "",
                                      "flexdaysbeforeout": "3",
                                      "flexdaysout" : "3",
                                      "flexdaysbeforein": "3",
                                      "flexdaysin": "3",
                                      "adt": adt,
                                      "teen": teen,
                                      "chd": chd,
                                      "roundtrip": "false",
                                      "ToUs": "AGREED"]
        
        let finalUrl = ConnectionController.addToURLGetQueryParams(url: ConnectionController.getValidUrl(url: Constants.flightsUrl), params: URLQueryItem.fromDict(dict: parameters))
        
        AF.request(finalUrl, method: .get).responseString { (flightsResponse) in
            if let flightsValue = flightsResponse.value {
                let flightsJson = JSON(parseJSON: flightsValue)
                
                if flightsJson.exists() && !flightsJson.isEmpty {
                    do {
                        let decoder = JSONDecoder()
                        flights = try decoder.decode(type(of: flights), from: flightsJson.rawData())
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    onResult(LabsApiResponse.onSuccess(model: flights, requestStatus: .success, basicResponse: LabsBasicResponse(error: false)))
                    return
                }
            } else {
                onResult(LabsApiResponse.onSuccess(model: flights, requestStatus: .failure, basicResponse: LabsBasicResponse(error: true)))
                return
            }
        }
        
    }
    
    static func addToURLGetQueryParams(url: String, params: [URLQueryItem]?) -> URLConvertible {
          
          guard var urlComponents = URLComponents(string: getValidUrl(url: url)) else {
              return ""
          }
          
          urlComponents.queryItems = params
          
          guard let urlAbsoluteString = urlComponents.url?.absoluteString else {
              return ""
          }
          
          return urlAbsoluteString
      }
    
    static func getValidUrl(url: String) -> String {
        return url.replacingOccurrences(of: "(?<!:)//", with: "/", options: .regularExpression).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
    }
    
    
    
}
