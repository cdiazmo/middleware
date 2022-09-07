//
//  Endpoint.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

public protocol Endpoint
{
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}
