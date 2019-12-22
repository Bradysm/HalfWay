//
//  EventType.swift
//  HalfWay
//
//  Created by brady murphy on 12/22/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation

/**
 Enum describing the type of an event
 */
enum EventType {
    case sports, food, entertainment, fitness, artsAndCrafts, general
}


extension EventType {
    
    /**
     Function which decodes a string representing the event type and returns an Enum describing the type of event
     */
    func getType(_ eventType: String) -> EventType {
        if eventType.contains("sport") {
            return .sports
        } else if eventType.contains("food") || eventType.contains("restaurant") {
            return .food
        } else if eventType.contains("entertainment") {
            return .entertainment
        } else if eventType.contains("gym") || eventType.contains("fitness") || eventType.contains("exercise") {
            return .fitness
        } else if eventType.contains("crafts") || eventType.contains("art") {
            return .artsAndCrafts
        }
        return .general
    }
}
