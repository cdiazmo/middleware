//
//  FRBMicroServiceForceUpgradeModel.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

@objcMembers
public class FRBMicroServiceForceUpgradeModel: NSObject, FRBMicroServiceModel, Codable
{
    
    let kFRBQ2ServiceResponseSupportedAPIKey = "isMinimumVersion"
    let kFRBQ2ServiceResponseAPIVersionKey = "onlineVersion"
    
    public var status: Int = -1
    public var versionNumber: String?
    public var isCritical: Bool = false
    public var isUpdateAvailable: Bool = false
    public var dispMsg: String?
    public var dispMsgEvery: String?
    public var dispMsgCountMax: String?
    public var featureFlag: Bool = false
    public var remindMeLaterLoginCount: String?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case versionNumber
        case isCritical
        case isUpdateAvailable = "isUpdateAvilable"
        case dispMsg
        case dispMsgEvery
        case dispMsgCountMax
        case featureFlag
        case remindMeLaterLoginCount
    }

    @objc public var isForceUpgradeAvailable: NSNumber
    {
        let isAvailable = isCritical && isUpdateAvailable
        return NSNumber(value: isAvailable)
    }

    required public init?(dictionary: NSDictionary)
    {
        status = dictionary[CodingKeys.status] as? Int ?? -1
        versionNumber = dictionary[CodingKeys.versionNumber] as? String
        isCritical = dictionary[CodingKeys.isCritical] as? Bool ?? false
        isUpdateAvailable = dictionary[CodingKeys.isUpdateAvailable] as? Bool ?? false
        dispMsg = dictionary[CodingKeys.dispMsg] as? String
        dispMsgEvery = dictionary[CodingKeys.dispMsgEvery] as? String
        dispMsgCountMax = dictionary[CodingKeys.dispMsgCountMax] as? String
        featureFlag = dictionary[CodingKeys.featureFlag] as? Bool ?? false
        remindMeLaterLoginCount = dictionary[CodingKeys.remindMeLaterLoginCount] as? String
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        versionNumber = try container.decode(String.self, forKey: .versionNumber)
        isCritical = try container.decode(Bool.self, forKey: .isCritical)
        isUpdateAvailable = try container.decode(Bool.self, forKey: .isUpdateAvailable)
        dispMsg = try container.decode(String.self, forKey: .dispMsg)
        dispMsgEvery = try container.decode(String.self, forKey: .dispMsgEvery)
        dispMsgCountMax = try container.decode(String.self, forKey: .dispMsgCountMax)
        featureFlag = try container.decode(Bool.self, forKey: .featureFlag)
        remindMeLaterLoginCount = try container.decode(String.self, forKey: .remindMeLaterLoginCount)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(versionNumber, forKey: .versionNumber)
        try container.encode(isCritical, forKey: .isCritical)
    }
//
//
//
//    @objc func logUnsupportedAPIError(error: Error?) -> String?
//    {
//        if !isForceUpgradeAvailable.boolValue, let error = error
//        {
//            return "Usupported API app update needed: \(String(describing: FRBUtilities.appName())) \(String(describing: FRBUtilities.appVersion())), \(kFRBQ2ServiceResponseSupportedAPIKey): \(isForceUpgradeAvailable.boolValue ? "true" : "false"), \(kFRBQ2ServiceResponseAPIVersionKey): \(String(describing: versionNumber))"
//
//        }
//        else
//        {
//            return nil
//        }
//    }
}
