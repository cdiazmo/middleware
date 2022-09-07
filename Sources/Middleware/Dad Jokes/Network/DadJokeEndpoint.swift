//
//  JokeEndpoint.swift
//
//
//  Created by Carlos Diaz on 9/7/22.
//

public class DadJokeEndpoint: Endpoint
{
    public var header: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    public var body: [String : String]?
    
    public var url: String {
        return "https://icanhazdadjoke.com"
    }
    
    public var method: RequestMethod
    {
        return .get
    }
}
