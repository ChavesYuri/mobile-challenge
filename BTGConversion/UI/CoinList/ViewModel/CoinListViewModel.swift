//
//  CoinListViewModel.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 20/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation

enum CurrencyType {
    case origin
    case target
}

class CoinListViewModel: ViewModelProtocol, CoinListViewModelProtocol {
    
    
    var viewModelDisplay: ViewModelDisplayProtocol?
    
    var tabbarItemText: String = ""
    
    var navTitleText: String = "Lista de moedas"
    
    var items: [CurrencyModel] = []
    
    var coordinator: ConversionCoordinator?
    
    var currencyType: CurrencyType = .origin
    
    init(coordinator: ConversionCoordinator?, type: CurrencyType) {
        self.coordinator = coordinator
        self.currencyType = type
    }
    
    
    func fetchCoinList() {
        viewModelDisplay?.displayLoading(true)
        Services.coinList { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                self.makeList(currencies: response.currencies ?? [:])
                guard let viewDisplay = self.viewModelDisplay as? CoinListViewModelDisplayProtocol else{return}
                viewDisplay.displayComponents()
                
            case .failure(let error):
                self.viewModelDisplay?.displayError(error.message)
            }
            self.viewModelDisplay?.displayLoading(false)
            
        }
    }
    
    func makeList(currencies: [String:String]){
        let items = currencies.reduce(into: [CurrencyModel]()) { (result, x) in
            result.append(CurrencyModel(initials: x.key, name: x.value))
        }
        self.items = items.sorted(by: { (item1, item2) -> Bool in
            return item1.initials < item2.initials
        })
        
    }
    
    func didSelectCurrency(currency: CurrencyModel) {
        switch currencyType {
        case .origin:
            coordinator?.dismissListAndSetupOriginCurrency(currency: currency)
        case .target:
            coordinator?.dismissListAndSetupTargetCurrency(currency: currency)
        }
    }
    
    
    
    
}
