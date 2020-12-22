//
//  ConversionViewModel.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation


class ConversionViewModel: ViewModelProtocol{
    var viewModelDisplay: ViewModelDisplayProtocol?
    
    let dolarCode = "USD"
    
    var tabbarItemText: String = ""
    
    var navTitleText: String = "Conversão"
    
    var textValue = ""
    
    var sourceCurrency = ""
    var targetCurrency = ""
    
    var quotes : [String: Double] = [:]
    
    var coordinator: ConversionCoordinator?
    
    init(coordinator: ConversionCoordinator?) {
        self.coordinator = coordinator
        
    }
    
    func openList(type: CurrencyType){
        coordinator?.coinList(type: type)
    }
    
    var formatterValue: Double{
        textValue = textValue.trimmingCharacters(in: .whitespacesAndNewlines)
        return LayoutHelper.stringToDecimal(string: textValue)?.doubleValue ?? 0
    }
    
    
    func submitConversion(){
        if validate(){
            if(quotes.count > 0){
                if sourceCurrency.elementsEqual(targetCurrency){
                    showResult(result: NSNumber(value: formatterValue))
                }else{
                    verifyIsDolarAndSubmit()
                }
            }else{
                viewModelDisplay?.displayError("Serviço temporariamente indisponível")
            }
            
        }else{
            viewModelDisplay?.displayError("Preencha todos os campos")
        }
    }
    
    
    func validate() -> Bool{
        return !sourceCurrency.elementsEqual("") && !targetCurrency.elementsEqual("") && !textValue.elementsEqual("")
    }
    
    func verifyIsDolarAndSubmit(){
        if(sourceCurrency.elementsEqual(dolarCode)){
            let value = dolarToAny(code: targetCurrency)
            showResult(result: NSNumber(value: value ?? 0))
        }else if (targetCurrency.elementsEqual(dolarCode)){
            let value = anyToDolar(code: sourceCurrency)
            showResult(result: NSNumber(value: value ?? 0))
        }else{
            // Duas moedas diferentes
            let dollarValue = anyToDolar(code: sourceCurrency)
            let result = dollarValueToAny(dolar: dollarValue ?? 0, code: targetCurrency)
            showResult(result: NSNumber(value: result ?? 0))
            
        }
    }
    
    func getQuotes(){
       
        self.displayLoading(display: true)
        quotesList {[weak self] (liveModel) in
            guard let self = self else {return}
            self.quotes = [:]
            self.quotes = liveModel?.quotes ?? [:]
            self.displayLoading(display: false)
        }
    }
    
    func quotesList(completion: @escaping (ConversionResponseModel?)-> Void){
        Services.conversionList { [weak self](response) in
            guard let self = self else {return}
            switch response{
            case .success(let result):
                completion(result)
            case .failure(let error):
                self.displayLoading(display: false)
                self.viewModelDisplay?.displayError(error.message)
            }
        }
    }
    
    private func displayLoading(display: Bool){
        guard let viewDisplay = viewModelDisplay as? ConversionViewController else {return}
        if(!display){
            DispatchQueue.main.async {
                viewDisplay.scrollView.refreshControl?.endRefreshing()
            }
        }
        viewDisplay.displayLoading(display)
    }
    
    
    
    func dolarToAny(code: String) -> Double?{
        if let value = valueForCode(code: code){
            let result = value * formatterValue
            return result
        }
        return nil
    }
    
    func anyToDolar(code: String) -> Double?{
        if let value = valueForCode(code: code){
            let result =  formatterValue / value
            return result
        }
        return nil
    }
    
    func dollarValueToAny(dolar: Double, code:String) -> Double?{
        if let value = valueForCode(code: code){
            return dolar * value
        }
        return nil
    }
    
    func valueForCode(code: String) -> Double?{
        let tag = "USD"+code
        if let value = quotes[tag] {
            return value
        }else{
            return nil
        }
    }
    
    func showResult(result: NSNumber?){
        guard let viewDisplay = viewModelDisplay as? ConversionViewModelDisplay else{return}
        if result != nil{
            
            viewDisplay.displayResult(result: result!.toCurrency() + " \(targetCurrency)")
        }else{
            viewModelDisplay?.displayError("Não foi possível fazer a conversão. Verifique os campos e tente novamente")
        }
        
    }
    
    
    
}
