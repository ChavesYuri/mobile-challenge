//
//  ViewModelDisplayProtocol.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation


// MARK: - Loading and Error
protocol ViewModelDisplayProtocol {
    func displayLoading(_ loading: Bool)
    func displayError(_ error: String?)
}

protocol ViewModelProtocol {
    var viewModelDisplay: ViewModelDisplayProtocol? { get set }
    var tabbarItemText: String { get }
    var navTitleText: String { get }
}


protocol ViewModelDrivenProtocol: class {
    var viewModel: ViewModelProtocol? { get }
}
