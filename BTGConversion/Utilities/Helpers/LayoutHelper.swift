//
//  CurrencyTextField.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
import UIKit

class LayoutHelper{
    static func stringToDecimal(string: String) -> NSNumber? {
        let value = string.replacingOccurrences(of: "R$", with: "")
            .replacingOccurrences(of: "%", with: "")
            .trimmingCharacters(in: .whitespaces)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if string.contains("%") || !string.contains(",") {
            if let res = formatter.number(from: value) {
                return res
            }
            if let double = Double(value) {
                return NSNumber(value: double)
            }
            formatter.locale = Locale(identifier: "en_US")
            return formatter.number(from: value)
        }
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.number(from: value)
    }
}
