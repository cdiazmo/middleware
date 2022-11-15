//
//  Endpoint.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

public protocol Endpoint
{
    var url: URL? { get }
    var method: RequestMethod { get }
    var header: [String: Any]? { get }
    var body: [String: Any]? { get }
}
