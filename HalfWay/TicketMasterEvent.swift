//
//  TicketMasterEvent.swift
//  HalfWay
//
//  Created by brady murphy on 12/22/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation


/**
 Struct representing an event
 Each event contains a
 */
struct Event: EventInfo {
    /**
     event details
     */
    var name: String
    var description: String
    var type: EventType
    var imageUrl: String
    
    /**
     Pricing and buying information
     */
    var price: String
    var website: String
    
    /**
     Variabels describing timing and location
     */
    var location: String
    var date: String
    
    
}
