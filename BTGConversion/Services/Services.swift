//
//  Services.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
class Services {
    
    class func coinList(completion: @escaping(Swift.Result<CoinListResponseModel, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: CoinListRequestModel()) { (result) in
            completion(result)
        }
    }
    
    class func conversionList(completion: @escaping(Swift.Result<ConversionResponseModel, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: ConversionRequestModel()) { (result) in
            completion(result)
        }
    }
}
