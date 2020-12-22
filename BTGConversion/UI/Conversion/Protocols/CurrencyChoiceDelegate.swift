//
//  CurrencyChoiceProtocol.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation


protocol CurrencyChoiceDelegate: class {
    func didSelectSourceCurrency(currency: CurrencyModel)
    func didSelectCurrencyTarget(currency: CurrencyModel)
}
