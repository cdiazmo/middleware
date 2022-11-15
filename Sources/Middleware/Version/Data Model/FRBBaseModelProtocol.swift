//
//  FRBBaseModelProtocol.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation
@objc protocol FRBBaseModelProtocol {
    @objc optional var returnErrorCode: Int { get }
    @objc optional var httpStatusCode: Int { get }
    
    @objc optional var isValid: Bool { get }
    @objc optional var validationError: Error? { get }
    init(
            serverResponse: [String : Any]?,
            validationKeys: [String]?
        )
    @objc optional func parseServerResponse(_ serverResponse: [String : Any]?)
    @objc optional func validateServerResponse(_ serverResponse: [String : Any]?) throws
    
    init(serverResponse: [String : Any]?)

    
    func cleanData()
}
