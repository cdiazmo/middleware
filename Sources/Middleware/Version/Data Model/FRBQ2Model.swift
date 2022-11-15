//
//  FRBQ2Model.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

enum FRBSharedErrorCode : Int {
    case frbClientErrorInvalidRequest = 40000
    case frbhttpResponseValidationErrorCode = 50000
    case frbhttpRequestMaxRetriesAttemptedCode = 50503
    case frbhttpResponseInvalidDataCode = 60000
    case frbCertificatePinningErrorCode = 90000
    case frbInvalidAddressErrorCode = 10000
    case frbErrorCodeBackgroundRequest = 90001
    case frbZelleEnrollmentMissingInfo = 13333
}


class FRBQ2Model: FRBBaseModelProtocol {
    
    required init(serverResponse: [String : Any]?) {
        isValid = true
        validationError = nil
    }
    
    func cleanData() {
        validationError = nil
    }
    
    internal var validationError: Error?
    internal var isValid = false
    let kFRBErrorDomainValidation = "com.firstrepublic.error-domain.validation"
    required init(
        serverResponse: [String : Any]?,
        validationKeys: [String]?
    ) {        
        validationError = nil
        
        var modelValidationError: Error? = nil
        
        isValid = validateModel(serverResponse, validationKeys, modelValidationError)
        if !isValid {
            validationError = modelValidationError
            
            //            applicationMonitorLogError(modelValidationError)
        } else {
            // Nothing else needs to be done,
            // The response has passed validation.
        }
    }
    
    func modelValidationError(_ keys: [String]?) -> Error? {
        var error: Error? = nil
        
        let validationFailureReason = NSLocalizedString("RESPONSE_VALIDATION_FAILURE_REASON", comment: "")
        let missingKeys = keys?.joined(separator: ",") ?? ""
        let oneOrMoreKeys = ((keys?.count ?? 0) == 1) ? "key was" : "keys were"
        var recoverySuggestion = String(
            format: "The following %@ not found: %@", oneOrMoreKeys, missingKeys)
        
        
//        error = NSError(
//            code: FRBSharedErrorCode.frbhttpResponseValidationErrorCode,
//            domain: kFRBErrorDomainValidation,
//            failureReason: validationFailureReason,
//            recoverySuggestion: recoverySuggestion)
        
        //            DDLogError("Validation error: %@", recoverySuggestion)
        
        //             applicationMonitorLeaveBreadcrumb(recoverySuggestion);
        //        applicationMonitorLogError(error);
        return error
    }
    
    func validateModel(
        _ serverResponse: [String : Any]?,
        _ modelValidationKeys: [String]?,
        _ error: Error?
    ) -> Bool {
        var error = error
        var didValidate = ((modelValidationKeys?.count ?? 0) > 0) ? false : true
        var missingKeys: [String] = []
        var validationError: Error? = nil
        
        guard let modelValidationKeys = modelValidationKeys else {
            return true
        }

        guard let serverResponse = serverResponse else {
            return false
        }
        
        for (idx, key) in modelValidationKeys.enumerated() {
            // Check for the existence of the keys in the response.
            didValidate = (serverResponse[key] != nil)
            
            if !didValidate {
                missingKeys.append(key)
            }
            else
            {
                // Keys found! Nothing else to do.
            }
        }
        if missingKeys.count > 0 {
            validationError = modelValidationError(missingKeys)
        } else {
            // Nothing to do, data passed validation.
        }
        
        if error != nil {
            error = validationError
        }
        
        let didPassValidation = validationError == nil
        
        return didPassValidation
    }
    
    
    func cleansedValue(_ value: Any?) -> Any? {
        var cleansedValue: Any? = nil

        if !(value is NSNull) {
            if let string = value as? String {
                cleansedValue = string.trimmingCharacters(in:.whitespacesAndNewlines)
            } else {
                cleansedValue = value
            }
        } else {
        }
        return cleansedValue
    }
}
