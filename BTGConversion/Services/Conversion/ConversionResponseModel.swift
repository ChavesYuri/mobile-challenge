//
//  ConversionResponseModel.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
class ConversionResponseModel: Codable, BaseResponse {
    var success: Bool = false
    var terms: String?
    var privacy: String?
    var quotes: [String:Double]?
}

struct CurrencyQuotes {
    var code: String
    var value: Double
}
