//
//  FRBQ2Version.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

private let kFRBVersionSupportContactKey = "contactInfo"
private let kFRBVersionIsMinimumKey = "isMinimumVersion"
private let kFRBQ2ServiceMillisecondsPerSecond = 1000
private let kFRBVersionResponseDataAccountExpectedWaitTimeKey = "accountExpectedWaitTime"
private let kFRBVersionResponseDataAccountMaximumWaitTimeKey = "accountMaximumWaitTime"
private let kFRBMaximumSecondsForAccountsTimeout: Float = 180.0
private let kFRBRetrySecondsForAccountsTimeout: Float = 1.0
let kFRBQ2AppVersionPrefix = "4.3"
let kFRBQ2APIVersionValueToReplace = ".FRB"
let kFRBQ2APIVersionReplacementValue = " v"

let kFRBQ2ServiceResponseAPIVersionKey = "onlineVersion"
let kFRBQ2ServiceResponseSupportInformationKey = "contactInfo"


class FRBQ2Version: FRBQ2Model, Codable {
   
    var version: String?
    var supportInformation: FRBSupportInformation?
    var waitTimeMaximumForAccounts: TimeInterval = 0.0
    var waitTimeExpectedForAccounts: TimeInterval = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case contactInfo
        case isMinimumVersion
        case accountExpectedWaitTime
        case accountMaximumWaitTime
    }
    
    required init(serverResponse: [String : Any]?) {
        super.init(
            serverResponse: serverResponse,
            validationKeys: [kFRBVersionSupportContactKey, kFRBVersionIsMinimumKey])
        populateWithValues(fromServerResponse: serverResponse)
        if !(isValid ) {
            waitTimeMaximumForAccounts = TimeInterval(kFRBMaximumSecondsForAccountsTimeout)
            waitTimeExpectedForAccounts = TimeInterval(kFRBRetrySecondsForAccountsTimeout)
        }
    }
    
    
    required init(serverResponse: [String : Any]?, validationKeys: [String]?) {
        super.init(
            serverResponse: serverResponse,
            validationKeys: [kFRBVersionSupportContactKey, kFRBVersionIsMinimumKey])
        populateWithValues(fromServerResponse: serverResponse)
        if !(isValid ) {
            waitTimeMaximumForAccounts = TimeInterval(kFRBMaximumSecondsForAccountsTimeout)
            waitTimeExpectedForAccounts = TimeInterval(kFRBRetrySecondsForAccountsTimeout)
//            applicationMonitorLeaveBreadcrumb("No version information was received.")
//            applicationMonitorLogError(validationError)
        }
    }
    
    required init(from decoder:Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        supportInformation = nil//try values.decode(FRBSupportInformation.self, forKey: .contactInfo)
        version = try values.decode(String.self, forKey: .isMinimumVersion)
        waitTimeMaximumForAccounts = try values.decode(TimeInterval.self, forKey: .accountMaximumWaitTime)
        waitTimeExpectedForAccounts = try values.decode(TimeInterval.self, forKey: .accountExpectedWaitTime)
        super.init(serverResponse: [:])
        }
    
    func encode(to encoder: Encoder) throws {
//           var container = encoder.container(keyedBy: CodingKeys.self)
//           try container.encode(id, forKey: .id)
//           try container.encode(title, forKey: .title)
//           try container.encode(number, forKey: .number)
//           try container.encode(imgUrl, forKey: .imgUrl)
//           try container.encode(thumbnail, forKey: .thumbnail)

       }
    
    

    func populateWithValues(fromServerResponse serverResponse: [AnyHashable : Any]?) {
        
        guard let serverResponse = serverResponse else {
            return
        }
        
        let cleanedMaximumTimeoutString = cleansedValue(serverResponse[ kFRBVersionResponseDataAccountMaximumWaitTimeKey]) as? String
        let cleanedExpectedTimeoutString = cleansedValue(serverResponse[ kFRBVersionResponseDataAccountExpectedWaitTimeKey]) as? String
        version = prepareAPIInformation(cleansedValue(serverResponse[kFRBQ2ServiceResponseAPIVersionKey]) as? String)
        supportInformation = prepareSupportContacts(cleansedValue(serverResponse[kFRBQ2ServiceResponseSupportInformationKey]) as? [String: Any])
        waitTimeMaximumForAccounts = convertMilliseconds(toSeconds: cleanedMaximumTimeoutString, fallbackDefault: kFRBMaximumSecondsForAccountsTimeout)
        waitTimeExpectedForAccounts = convertMilliseconds(toSeconds: cleanedExpectedTimeoutString, fallbackDefault: kFRBRetrySecondsForAccountsTimeout)
    }
    
    func convertMilliseconds(toSeconds timeInMillisecondsString: String?, fallbackDefault defaultValue: Float) -> TimeInterval {
        let formatter = NumberFormatter()

        formatter.numberStyle = .decimal

        if let timeInMillisecondsString = timeInMillisecondsString,
            let formattedTimeout = formatter.number(from: timeInMillisecondsString) {
            return TimeInterval(formattedTimeout.intValue / kFRBQ2ServiceMillisecondsPerSecond)
        } else {
            return TimeInterval(defaultValue)
        }
        
    }
    func prepareAPIInformation(_ apiVersion: String?) -> String? {
        var version: String? = nil

        if let apiVersion = apiVersion {
            version = apiVersion.replacingOccurrences(
                of: kFRBQ2APIVersionValueToReplace,
                with: kFRBQ2APIVersionReplacementValue)
        } else {
            version = NSLocalizedString("API_VERSION_NOT_AVAILABLE_MESSAGE", comment: "")
        }

        return version
    }
    
    func prepareSupportContacts(_ serverResponse: [String : Any]?) -> FRBSupportInformation? {
        
        guard let serverResponse = serverResponse
                else
                {
                    return nil
                }
        
        let support = FRBSupportInformation(serverResponse: serverResponse)

        return support
    }

    func createVersion() -> FRBVersion? {
        let version = FRBVersion(q2Version: self)

        return version
    }
}
