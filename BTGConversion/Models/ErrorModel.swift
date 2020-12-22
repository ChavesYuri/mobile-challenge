//
//  ErrorModel.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation

class ErrorModel: Error {
    
    // MARK: - Properties
    var messageKey: String
    var message: String {
        return messageKey.localized()
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions
extension ErrorModel {
    
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
    
    class func networkError() -> ErrorModel {
        return ErrorModel(ErrorKey.networkError.rawValue)
    }
}
