//
//  Event.swift
//  HalfWay
//
//  Created by brady murphy on 12/22/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation

/**
 Struct representing an event in time
 This event can be food, fitness, and anything in between
 */
struct Event: EventInfo {
    /**
     Event description
     */
    var name: String
    var description: String
    var type: EventType
    var imageUrl: String
    
    /**
     Pricing information
     */
    var price: Double
    var website: String
    
    /**
     Location information
     */
    var location: String
    var date: String
}
