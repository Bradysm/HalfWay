//
//  Networking.swift
//  HalfWay
//
//  Created by brady murphy on 12/22/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation

/**
 Default networking function to make an API call from a given URL string
 This function takes a completion handler for JSON parsing, the completion handler is expected to handle parsing errors and return result accordingly
 
 @Param - from: string containing URL to get the data from
 @Param - parsingHandler: completion handler that takes a type of Any which is a json object, it is then expected to parse this object and return a result containing the data on success
 @Return - result containing success or failure from the API request
 */
func fetchJsonFromUrl<ApiData>(from urlString: String, parsingHandler: @escaping (Any) -> Result<ApiData, NetworkError>) -> Result<ApiData, NetworkError> {
    guard let url = URL(string: urlString) else { return .failure(.invalidUrl) }
    
    // make API call using a semaphore for synchronization
    var result: Result<ApiData, NetworkError>!
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: url) { (data, res, err) in
        
        // check for networking errors
        if let _ = err { result = .failure(.badRequest); semaphore.signal(); return }
        
        // try to serialize JSON data and call parser
        do {
            guard let data = data else { result = .failure(.emptyData); semaphore.signal(); return }
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            result = parsingHandler(json)
            semaphore.signal()
        } catch {
            result = .failure(.invalidJsonData)
            semaphore.signal()
        }
    }.resume()
    
    // wait for 8 seconds and then call it a day, notify a network timeout
    if semaphore.wait(timeout: .now() + 8.0) == .timedOut {
        result = .failure(.networkTimeout)
    }
    return result
}
