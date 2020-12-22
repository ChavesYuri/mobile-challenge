//
//  ConversionCoordinator.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
import UIKit


class ConversionCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    weak var delegate: CurrencyChoiceDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        conversion()
    }
    
    
    func coinList(type: CurrencyType) {
        let viewModel = CoinListViewModel(coordinator: self, type: type)
        let vc = CoinListViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func conversion(){
        let viewModel = ConversionViewModel(coordinator: self)
        let vc = ConversionViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismissListAndSetupOriginCurrency(currency: CurrencyModel){
        self.navigationController.popViewController(animated: false)
        delegate?.didSelectSourceCurrency(currency: currency)
    }
    
    func dismissListAndSetupTargetCurrency(currency: CurrencyModel){
        self.navigationController.popViewController(animated: false)
        delegate?.didSelectCurrencyTarget(currency: currency)
    }
    
    
    
    
}
