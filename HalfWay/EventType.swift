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



/**
 Function which decodes a string representing the event type and returns an Enum describing the type of event
 */
func getEventType(_ eventType: String) -> EventType {
    let lowerEventType = eventType.lowercased()
    if lowerEventType.contains("sport") {
        return .sports
    } else if lowerEventType.contains("food") || lowerEventType.contains("restaurant") {
        return .food
    } else if lowerEventType.contains("entertainment") {
        return .entertainment
    } else if lowerEventType.contains("gym") || lowerEventType.contains("fitness") || lowerEventType.contains("exercise") {
        return .fitness
    } else if lowerEventType.contains("crafts") || lowerEventType.contains("art") {
        return .artsAndCrafts
    }
    return .general
}

