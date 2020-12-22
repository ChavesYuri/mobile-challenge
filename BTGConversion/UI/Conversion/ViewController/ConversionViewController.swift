//
//  ConversionViewController.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import UIKit

class ConversionViewController: BaseViewController {
    
    @IBOutlet var coinOriginLabel: UILabel!
    @IBOutlet var coinDestinyLabel: UILabel!
    
    @IBOutlet var valueTextField: UITextField!
    
    @IBOutlet var conversionValueLabel: UILabel!
    @IBOutlet var stackResult: UIStackView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    var amt = 0
    
    init(viewModel: ViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.viewModelDisplay = self
        title = viewModel?.navTitleText
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        registernNotifications()
        loadQuotes()
        configureRefreshControl()
        
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
    
    func configureRefreshControl() {
       scrollView.refreshControl = UIRefreshControl()
       scrollView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        guard let viewModel = viewModel as? ConversionViewModel else { return }
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.beginRefreshing()
        }
        viewModel.getQuotes()
    }
    
    func loadQuotes(){
        guard let viewModel = viewModel as? ConversionViewModel else{return}
        viewModel.getQuotes()
    }
    
    func updateTextField() -> String?{
        let number = Double(amt/100) + Double (amt%100)/100
        return NSNumber(value: number).toCurrency()
    }
    
    func setupDelegate(){
        guard let viewModel = viewModel as? ConversionViewModel else{return}
        viewModel.coordinator?.delegate = self
        valueTextField.delegate = self
        valueTextField.placeholder = updateTextField()
    }
    
    func registernNotifications(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    
    
    @IBAction func sourceCurrencyAction(_ sender: Any) {
        guard let viewModel = viewModel as? ConversionViewModel else{return}
        viewModel.openList(type: .origin)
    }
    
    @IBAction func targetCurrencyAction(_ sender: Any) {
        guard let viewModel = viewModel as? ConversionViewModel else{return}
        viewModel.openList(type: .target)
    }
    
    @IBAction func conversionAction(_ sender: Any) {
        guard let viewModel = viewModel as? ConversionViewModel else {return}
        viewModel.submitConversion()
    }
}

extension ConversionViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let viewModel = viewModel as? ConversionViewModel else {return true}
        if let digit = Int(string){
            amt = amt * 10 + digit
            
            valueTextField.text = updateTextField()
        }
        if string == ""{
            amt = amt/10
            valueTextField.text = updateTextField()
            
        }
        viewModel.textValue = updateTextField() ?? "0"
        return false
    }
}

extension ConversionViewController: CurrencyChoiceDelegate{
    func didSelectSourceCurrency(currency: CurrencyModel) {
        coinOriginLabel.text = currency.initials
        guard let viewModel = viewModel as? ConversionViewModel else {
            return
        }
        viewModel.sourceCurrency = currency.initials
    }
    
    func didSelectCurrencyTarget(currency: CurrencyModel) {
        coinDestinyLabel.text = currency.initials
        guard let viewModel = viewModel as? ConversionViewModel else {
            return
        }
        viewModel.targetCurrency = currency.initials
        
    }
}

extension ConversionViewController: ConversionViewModelDisplay{
    func displayResult(result: String) {
        conversionValueLabel.text =  result 
        stackResult.isHidden = false
    }
    
    
}
