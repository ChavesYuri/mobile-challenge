//
//  NSNumber+Extension.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation



private extension NumberFormatter {
    class func btgNumberFormat() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true

        return formatter
    }
}

extension NSNumber {

    private class func formatNumber(_ number: NSNumber?) -> String? {
        let formatter = NumberFormatter.btgNumberFormat()
        if let aNumber = number {
            return formatter.string(from: aNumber)
        }
        return nil
    }

    func toCurrency() -> String {
        guard let string = NSNumber.formatNumber(self.absoluteValue()) else { return "" }
        let prefix = doubleValue >= 0 ? "" : "- "
        return prefix + " " + string
    }

    /**
     Returns the absolute value of the number
     
     - returns: NSNumber
     */
    func absoluteValue() -> NSNumber {
        return NSNumber(value: fabs(self.doubleValue))
    }

    /**
     Returns the current float number with comma as its separator
     
     - returns: String
     */
    func valueWithCommaSeparator() -> String? {
        return NSNumber.formatNumber(self)
    }
}
