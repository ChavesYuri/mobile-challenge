//
//  CoinListResponseModel.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
class CoinListResponseModel: Codable, BaseResponse {
    var success: Bool = false
    var terms: String?
    var privacy: String?
    var currencies: [String:String]?
}

struct CurrencyModel {
    var initials: String
    var name: String
}
