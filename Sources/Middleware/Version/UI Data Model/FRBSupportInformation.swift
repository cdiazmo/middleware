//
//  File.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

private let kFRBSupportInformationLoanServiceCaptionKey = "loanServicesLabel"
private let kFRBSupportInformationLoanServicePhoneNumberKey = "loanServicesNumber"
private let kFRBSupportInformationSupportCaptionKey = "supportLabel"
private let kFRBSupportInformationSupportPhoneNumberKey = "supportNumber"
private let kFRBSupportInformationSupportHelpLink = "helpLink"

class FRBSupportInformation: FRBQ2Model {
    private var supportContacts: [FRBSupportContact]?
    private var onlineBankingSupport: FRBSupportContact?
    private var loanServices: FRBSupportContact?
    private var customerCare: FRBSupportContact?
    
    
    func sharedInit() {
        supportContacts = nil
        onlineBankingSupport = nil
        loanServices = nil
        customerCare = nil
    }
    
    required init(serverResponse: [String : Any]?)
    {
        super.init(
            serverResponse: serverResponse,
            validationKeys: [
                kFRBSupportInformationLoanServiceCaptionKey,
                kFRBSupportInformationLoanServicePhoneNumberKey,
                kFRBSupportInformationSupportCaptionKey,
                kFRBSupportInformationSupportPhoneNumberKey])
        if isValid {
            sharedInit()
            populateWithValues(fromServerResponse: serverResponse)
        } else {
            sharedInit()
//            applicationMonitorLeaveBreadcrumb("Invalid support information data received.")
//            applicationMonitorLogError(validationError)
            useFallbackSupportInformation()
        }
    }
    
    required init(serverResponse: [String : Any]?, validationKeys: [String]?) {
        super.init(
            serverResponse: serverResponse,
            validationKeys: [
                kFRBSupportInformationLoanServiceCaptionKey,
                kFRBSupportInformationLoanServicePhoneNumberKey,
                kFRBSupportInformationSupportCaptionKey,
                kFRBSupportInformationSupportPhoneNumberKey])
        if isValid {
            sharedInit()
            populateWithValues(fromServerResponse: serverResponse)
        } else {
            sharedInit()
//            applicationMonitorLeaveBreadcrumb("Invalid support information data received.")
//            applicationMonitorLogError(validationError)
            useFallbackSupportInformation()
        }

//        return self
    }
    
    init() {
        super.init(
            serverResponse: [:],
            validationKeys: [])

        sharedInit()
        useFallbackSupportInformation()
    }

    func populateWithValues(fromServerResponse serverResponse: [AnyHashable : Any]?) {
        var listOfContacts: [FRBSupportContact] = []

        if let serverResponse = serverResponse {
            let supportCaption = serverResponse[ kFRBSupportInformationSupportCaptionKey] as? String
            let supportPhoneNumber = serverResponse[ kFRBSupportInformationSupportPhoneNumberKey] as? String
            let supportContact = FRBSupportContact(
                contactType: FRBSupportContactType.onlineBankingSupport,
                caption: supportCaption,
                phoneNumber: supportPhoneNumber)
            //supportContact
            
            listOfContacts.append(supportContact)
            let loanCaption = serverResponse[ kFRBSupportInformationLoanServiceCaptionKey] as? String
            let loanPhoneNumber = serverResponse[ kFRBSupportInformationLoanServicePhoneNumberKey] as? String
            let loanContact = FRBSupportContact(
                contactType: FRBSupportContactType.loanServices,
                caption: loanCaption,
                phoneNumber: loanPhoneNumber)
                loanServices = loanContact

                listOfContacts.append(loanContact)
            

        }
            supportContacts = listOfContacts
    }
    
    func useFallbackSupportInformation() {
        let fallbackSupportInformation = [
            kFRBSupportInformationSupportCaptionKey: "Online Banking Support",
            kFRBSupportInformationSupportPhoneNumberKey: "(855) 886-4819",
            kFRBSupportInformationLoanServiceCaptionKey: "Loan Servicing",
            kFRBSupportInformationLoanServicePhoneNumberKey: "(800) 888-6994",
            kFRBSupportInformationLoanServicePhoneNumberKey: "(800) 888-6994",
                    "helplink": "https://www.firstrepublic.com/engage/digital-banking-help"]
        populateWithValues(fromServerResponse: fallbackSupportInformation)
    }
    
}
