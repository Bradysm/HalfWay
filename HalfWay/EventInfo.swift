//
//  Activity.swift
//  HalfWay
//
//  Created by brady murphy on 12/21/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation

/**
 Protocol representing the requirements of an Activity in the application
 Any event, restauraunt, museum, etc is considered an acticity
 The activity must have a name, description, price range, location, and website url
 
 Activities must also provide a date. This is to ensure that one day events are noted
 as well as the dates of restauraunts and their openings.
 */
protocol EventInfo {
    // descriptions of the activity
    var name: String { get }
    var description: String { get }
    var type: EventType { get }
    var imageUrl: String { get }
    
    /**
     Pricing and buying information
     */
    var price: Double { get }
    var website: String { get }
    
    // activity location and date
    var location: String { get }
    var date: String { get }
}
