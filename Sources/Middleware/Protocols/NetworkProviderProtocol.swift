//
//  NetworkProtocol.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

public protocol NetworkProtocol
{
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}
