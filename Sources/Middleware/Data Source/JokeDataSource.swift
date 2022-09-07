//
//  JokeDataSource.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

public protocol JokeDataSourceProtocol
{
    func getData() async -> JokeModel?
}

public class JokeDataSource
{
    private let networkProvider: NetworkProtocol
    
    public init(networkProvider: NetworkProtocol)
    {
        self.networkProvider = networkProvider
    }
}

extension JokeDataSource : JokeDataSourceProtocol
{
    public func getData() async -> JokeModel? {
        let result = await networkProvider.sendRequest(endpoint: JokeEndpoint(), responseModel: JokeDataModel.self)
        
        switch result
        {
        case .success(let data):
            return JokeModel(createdAt: data.createdAt, value: data.value)
        case .failure:
            return nil
        }
    }
}
