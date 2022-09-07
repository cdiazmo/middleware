//
//  JokeDataSource.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

protocol JokeDataSourceProtocol
{
    func getData() async
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
    func getData() async {
//        let response = async networkProvider.sendRequest(endpoint: JokeEndpoint(), responseModel: JokeDataModel.self)
    }
}
