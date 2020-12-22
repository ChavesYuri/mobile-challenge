//
//  CoinListViewModelProtocol.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 20/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
protocol CoinListViewModelProtocol {
    func fetchCoinList()
    func didSelectCurrency(currency: CurrencyModel)
}

protocol CoinListViewModelDisplayProtocol {
    func displayComponents()
}
