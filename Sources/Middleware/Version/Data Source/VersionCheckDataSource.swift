//
//  File.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

public protocol VersionCheckDataSourceProtocol
{
    func getData(endpoint: Endpoint) async -> FRBMicroServiceForceUpgradeModel?
}

public class VersionCheckDataSource
{
    private let networkProvider: NetworkProtocol
    
    public init(networkProvider: NetworkProtocol)
    {
        self.networkProvider = networkProvider
    }
}

extension VersionCheckDataSource : VersionDataSourceProtocol
{
    public func getData(endpoint: Endpoint) async -> FRBMicroServiceForceUpgradeModel? {

        let result = await networkProvider.sendRequest(endpoint: endpoint, responseModel: FRBMicroServiceForceUpgradeModel.self)
        
        switch result
        {
        case .success(let data):
            return data
        case .failure:
            return nil
        }
    }
}
