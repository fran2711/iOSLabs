//
//  Stations.swift
//  iOSLabs
//
//  Created by Fran Lucena on 16/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import Foundation

struct AirportsList: Codable {
    var airports: [Airport]?
}

struct Airport: Codable {
    var name: String?
    var alternateName: String?
    var alias: [String]?
    var countryCode: String?
    var countryName: String?
    var countryAlias: String?
    var countryGroupCode: String?
    var countryGroupName: String?
    var timeZoneCode: String?
    var latitude: String?
    var longitude: String?
    var mobileBoardingPass: Bool?
    var markers: [Market]?
    var notices: String?
    var tripCardImageUrl: String?
    
}

struct Market: Codable {
    var code: String?
    var group: String?
}

enum AirportsStatusCode {
    case success, failure
}
