//
//  VersionEndpoint.swift
//
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

public class VersionCheckEndpoint: Endpoint
{
    private enum Header
    {
        static let forceUpgradeVersionNumberKey = "versionNumber"
        static let channelKey = "channelId"
        static let correlationKey = "correlationId"
        static let X_Correlation_Id = "X-Correlation-Id"
        static let sourceKey = "sourceId"
        static let osTypeKey = "osType"
        static let authorizationKey = "Authorization"
        static let webSessionIdKey = "webSessionId"
        static let deviceIdKey = "deviceId"
        static let deviceIpKey = "deviceIp"
        static let finalTargetUrlKey = "finalTargetUrl"
        static let channelValue = "MOBILE"
        static let sourceValue = "CONSDB"
        static let osTypeValue = "ios"
    }
    
    private enum MicroserviceKey
    {
        static let kFRBHTTPStatusCodeOK = 200
        static let kFRBHTTPResponseKey = "httpResponse"
        static let kFRBHTTPResponseDataKey = "httpResponseData"
        static let dataPassWebKey = "dataPassWebKey"
    }
    
    private let forceUpgradeEndpoint = "/digital/mobile/v1/consumer/version"
    private let token: String
    private let baseUrl: URL
    private let buildNumber: String

    public init(baseUrl: URL, token: String, buildNumber: String)
    {
        self.baseUrl = baseUrl
        self.token = token
        self.buildNumber = buildNumber
    }

    public var url: URL?
    {
        URL(string: forceUpgradeEndpoint, relativeTo: baseUrl)
    }

    public var body: [String : Any]?

    public var header: [String : Any]?
    {
        [Header.forceUpgradeVersionNumberKey: buildNumber,
         Header.channelKey: Header.channelValue,
         Header.correlationKey: UUID().uuidString,
         Header.sourceKey: Header.sourceValue,
         Header.osTypeKey: Header.osTypeValue,
         Header.authorizationKey: "Bearer \(token)"]
    }

    public var method: RequestMethod
    {
        .get
    }
}
