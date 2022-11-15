//
//  FRBSupportContact.swift
//  
//
//  Created by Carlos Diaz on 11/14/22.
//

import Foundation

enum FRBSupportContactType : Int {
    case notSpecified
    case onlineBankingSupport
    case customerCare
    case loanServices
}

class FRBSupportContact {
    private var caption: String?
    private var phoneNumber: String?
    private var type: FRBSupportContactType?

    init(
        contactType type: FRBSupportContactType,
        caption: String?,
        phoneNumber: String?
    ) {
        self.type = type
        self.caption = caption
        self.phoneNumber = phoneNumber
    }
}
        
