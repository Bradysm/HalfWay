//
//  TicketMasterParser.swift
//  HalfWay
//
//  Created by brady murphy on 12/22/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation


/**
 Parser used as a networking completion handler for ticket master discovery API calls
 If the given json object does not meet the stated API requirements, then an invalidJsonData error is returned as the result
 otherwise, the data is parsed and an array of Event structs is returned on success
 
 @Param: json - json object to be parsed
 @Return: failure if the JSON data is invalid and success containing the parsed JSON events
 */
func ticketMasterDiscoveryParser(json: Any) -> Result<[Event], NetworkError> {
    // check for invalid JSON data
    guard let jsonDict = json as? [String: Any] else { return .failure(.invalidJsonData) }
    guard let embeddedData = jsonDict["_embedded"] as? [String: Any] else { return .failure(.invalidJsonData) }
    guard let events = embeddedData["events"] as? [[String: Any]] else { return .failure(.invalidJsonData) }
    
    // nice functional programming to make life easier
    return .success(events.map{ parseTicketMasterEvent(eventJson: $0) }.compactMap{ $0 })
}


/**
 Parses ticket master event JSON and returns an Event struct
 If the JSON data is invalid, then nil will be returned, representing invalid data
 
 Name, location, and website must all be available for JSON to be valid
 
 @eventJson: Dictionary representing JSON from ticketmaster API
 @Return: Event struct filled with all event information, nil JSON is not valid
 */
fileprivate func parseTicketMasterEvent(eventJson: [String: Any]) -> Event? {
    var result: Event?
    
    // filter out objects that do not contain required values
    guard let name = eventJson["name"] as? String else { return result }
    guard let websiteUrl = eventJson["url"] as? String else { return result }
    
    
    let description = eventJson["info"] as? String ?? "Description not available"
    
    
    
    
    return result
}



/**
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
 var price: String
 var website: String
 
 /**
  Location information
  */
 var location: String
 var date: String
 */
