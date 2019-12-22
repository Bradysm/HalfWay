//
//  NetworkError.swift
//  HalfWay
//
//  Created by brady murphy on 12/22/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import Foundation

/**
 Enum representing errors resulting from networking code
 */
enum NetworkError: Error {
    case invalidUrl, invalidJsonData, badRequest, emptyData, networkTimeout
}
