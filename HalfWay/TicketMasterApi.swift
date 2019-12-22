//
//  TicketMasterApi.swift
//  HalfWay
//
//  Created by brady murphy on 12/22/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation

fileprivate let ticketMasterUrl = ""
fileprivate let apiKey = ""

/**
 Fetches ticket master events local to the area and returns an array containing the local events
 
 @Return - Event array
 */
func fetchTicketMasterEvents() -> [Event] {
    switch fetchDataFromUrl(from: ticketMasterUrl, parsingHandler: ticketMasterDiscoveryParser) {
    case .success(let events):
        return events
    case .failure:
        return [Event]()
    }
}
