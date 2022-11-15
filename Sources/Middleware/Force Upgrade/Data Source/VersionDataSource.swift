//
//  File.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

public protocol VersionDataSourceProtocol
{
    func getData(endpoint: Endpoint) async -> FRBMicroServiceForceUpgradeModel?
}

public class VersionDataSource
{
    private let networkProvider: NetworkProtocol
    
    public init(networkProvider: NetworkProtocol)
    {
        self.networkProvider = networkProvider
    }
}

extension VersionDataSource : VersionDataSourceProtocol
{
    public func getData(endpoint: Endpoint) async -> FRBMicroServiceForceUpgradeModel? {

        let result = await networkProvider.sendRequest(endpoint: endpoint)
        
        switch result
        {
        case .success(let data):
            let responseModelData = FRBMicroServiceForceUpgradeModel(dictionary: data as NSDictionary)
            return responseModelData
        case .failure:
            return nil
        }
    }
}
