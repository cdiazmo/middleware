//
//  JokeEndpoint.swift
//
//
//  Created by Carlos Diaz on 9/7/22.
//

public class JokeEndpoint: Endpoint
{
    public var header: [String : String]?
    
    public var body: [String : String]?
    
    public var url: String {
        return "https://api.chucknorris.io/jokes/random"
    }
    
    public var method: RequestMethod
    {
        return .get
    }
}
