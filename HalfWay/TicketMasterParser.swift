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
 The price of the event can not be determined from the JSON data, as a result, -1 is used to let the user know to check the website
 
 @eventJson: Dictionary representing JSON from ticketmaster API
 @Return: Event struct filled with all event information, nil JSON is not valid
 */
fileprivate func parseTicketMasterEvent(eventJson: [String: Any]) -> Event? {
    var result: Event?
    
    // filter out objects that do not contain required values
    guard let name = eventJson["name"] as? String else { return result }
    guard let websiteUrl = eventJson["url"] as? String else { return result }
    
    let description = eventJson["info"] as? String ?? "Description not available"
    let eventType = parseEventType(eventJson)
    let imageUrl = parseImageUrl(eventJson)
    let date = parseEventDate(eventJson)
    let venueLocation = parseVenueLocation(eventJson)
    
    result = Event(name: name, description: description, type: eventType, imageUrl: imageUrl, price: -1.00, website: websiteUrl, location: venueLocation, date: date)
    return result
}

/**
 Parses the given event JSON object and returns the event type from the object
 using the classifications from ticket master
 
 @Return specific event type if available, and general if the event type is not known
 */
fileprivate func parseEventType(_ eventJson: [String: Any]) -> EventType {
    // get all the classifications, then filter to the primary classification
    guard let classifications = eventJson["classifications"] as? [[String: Any]],
        let classification = classifications.filter({ $0["primary"] as? Bool ?? false }).first
        else { return EventType.general}
    
    guard let segment = classification["segment"] as? [String: String],
        let name = segment["name"]
        else { return EventType.general }
    
    return getEventType(name)
}


/**
 Parses the eventJson object and returns the image's URL if an image is available
 If an image URL is not available, then an empty string is returned
 
 @Param - eventJson: Ticket master JSON objet for an event
 @Return image URL of the given image, or an empty string if there is no image available
 */
fileprivate func parseImageUrl(_ eventJson: [String: Any]) -> String {
    guard let images = eventJson["images"] as? [[String: Any]],
        let image = images.first
        else { return "" }
    
    return image["url"] as? String ?? ""
}


/**
 Parses eventJson and returns a string representation of the date of the event
 If the date is available, the date will be returned in the format YYYY-mm-dd
 If the date is not available, or is TBD, then TBD will be returned from the function
 
 @Param - eventJson: Ticket master JSON objet for an event
 @Return string containing the date or TBD
 */
fileprivate func parseEventDate(_ eventJson: [String: Any]) -> String {
    // get the start date object
    guard let dates = eventJson["dates"] as? [String: Any],
        let startDate = dates["start"] as? [String: Any]
        else { return "TBD" }
    
    guard let tbd = startDate["dateTBD"] as? Bool,
        let tba = startDate["dateTBA"] as? Bool,
        let date = startDate["localDate"] as? String
        else { return "TBD" }
    
    // check to see if the event is tbd or tba
    if tba || tbd {
        return "TBD"
    }
    return date
}

/**
Parses eventJson and returns a string representation of the location of the venue
If the venue name is available, then the name of the venue will be returned
else, a string stating that the venue is TBA will be returned

@Param - eventJson: Ticket master JSON objet for an event
@Return string containing event venue or string stating it's to be announced
*/
fileprivate func parseVenueLocation(_ eventJson: [String: Any]) -> String {
    guard let embeddedData = eventJson["_embedded"] as? [String: Any],
        let venues = embeddedData["venues"] as? [[String: Any]],
        let venue = venues.first
        else { return "Venue is TBD" }
    
    guard let state = venue["state"] as? [String: String],
        let country = venue["country"] as? [String: String],
        let city = venue["city"] as? [String: String],
        let venueName = venue["name"] as? String,
        let cityName = city["name"],
        let stateName = state["name"],
        let countryName = country["name"]
        else { return "Venue is TBD" }
    
    return "\(venueName), \(cityName) \(stateName), \(countryName)"
}
