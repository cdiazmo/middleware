//
//  FRBVersion.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

public class FRBVersion {
    
    private(set) var version = ""
    private(set) var supportInformation: FRBSupportInformation?
    private(set) var isSupportedAPI = false
    private(set) var waitTimeMaximumForAccounts: TimeInterval = 0.0
    private(set) var waitTimeExpectedForAccounts: TimeInterval = 0.0
    
    
    
    init(q2Version: FRBQ2Version?)
    {
        version = q2Version?.version ?? ""
        supportInformation = q2Version?.supportInformation
        waitTimeMaximumForAccounts = q2Version?.waitTimeMaximumForAccounts ?? 0.0
        waitTimeExpectedForAccounts = q2Version?.waitTimeExpectedForAccounts ?? 0.0
    }
}
