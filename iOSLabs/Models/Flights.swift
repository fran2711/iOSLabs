//
//  Flights.swift
//  iOSLabs
//
//  Created by Fran Lucena on 17/06/2020.
//  Copyright © 2020 Fran Lucena. All rights reserved.
//

import Foundation

struct Flights: Codable {
    var termsOfUse: String?
    var currency: String?
    var currPrecision: Int?
    var routeGroup: String?
    var tripType: String?
    var upgradeType: String?
    var trips: [Trip]?
    var serverTimeUTC: String?
}

struct Trip: Codable {
    var origin: String?
    var originName: String?
    var destination: String?
    var destinationName: String?
    var routeGroup: String?
    var tripType: String?
    var upgradeType: String?
    var dates: [FlightDates]?
}

struct FlightDates: Codable {
    var dateOut: String?
    var flights: [Flight]?
    
}

struct Flight: Codable {
    var faresLeft: Int?
    var flightKey: String?
    var infantsLeft: Int?
    var regularFare: RegularFare?
    var operatedBy: String?
    var segments: [Segment]?
    var flightNumber: String?
    var time: [String]?
    var timeUTC: [String]?
    var duration: String?
    
    
}


struct RegularFare: Codable {
    var fareKey: String?
    var fareClass: String?
    var fares: [Fare]?
}

struct Fare: Codable {
    var type: String?
    var amount: Double?
    var count: Int?
    var hasDiscount: Bool?
    var publishedFare: Double?
    var discountInPercent: Double?
    var hasPromoDiscount: Bool?
    var discountAmount: Double
}

struct Segment: Codable {
    var segmentNr: Int?
    var origin: String?
    var destination: String?
    var flightNumber: String?
    var time: [String]?
    var timeUTC: [String]?
    var duration: String?
}


enum FlightsStatusCode {
    case success, failure
}
