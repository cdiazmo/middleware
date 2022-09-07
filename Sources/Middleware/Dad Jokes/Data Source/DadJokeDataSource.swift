//
//  JokeDataSource.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

public protocol DadJokeDataSourceProtocol
{
    func getData() async -> DadJokeModel?
}

public class DadJokeDataSource
{
    private let networkProvider: NetworkProtocol
    
    public init(networkProvider: NetworkProtocol)
    {
        self.networkProvider = networkProvider
    }
}

extension DadJokeDataSource : DadJokeDataSourceProtocol
{
    public func getData() async -> DadJokeModel? {
        let result = await networkProvider.sendRequest(endpoint: DadJokeEndpoint(), responseModel: DadJokeDataModel.self)
        
        switch result
        {
        case .success(let data):
            return DadJokeModel(value: data.joke)
        case .failure:
            return nil
        }
    }
}
