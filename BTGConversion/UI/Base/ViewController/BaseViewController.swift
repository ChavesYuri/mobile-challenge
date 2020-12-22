//
//  BaseViewController.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, ViewModelDisplayProtocol {
    
    var viewModel: ViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.tabbarItemText
        navigationItem.title = viewModel?.navTitleText
    }
    
}
extension BaseViewController {
    
    func displayLoading(_ loading: Bool){
        DispatchQueue.main.async {
            loading ? LoadingHelper.showProgressIndicator(view: self.view) : LoadingHelper.hideProgressIndicator(view: self.view)
        }
    }
    
    open func displayError(_ error: String?){
        DispatchQueue.main.async {
            DialogHelper.showAlertMessage(vc: self, titleStr: "Ops!", messageStr: error ?? "Desculpe, ocorreu um erro ao processar sua solicitação")
        }
        
    }
    
}
