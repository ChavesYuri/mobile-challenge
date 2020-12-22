//
//  CoinListViewController.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 20/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import UIKit

class CoinListViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var footerView: UIView!
    
    
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
        setupTableView()
        loadItems()
    }
    
    func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(CoinListTableViewCell.nib, forCellReuseIdentifier: CoinListTableViewCell.identifier)
    }
    
    private var selectedCurrency: Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func updateSelectedIndex(_ index: Int) {
        selectedCurrency = index
    }
    
    func loadItems(){
        guard let viewModel = viewModel as? CoinListViewModelProtocol else{return}
        viewModel.fetchCoinList()
    }

    @IBAction func didSelectCurrency(_ sender: Any) {
        guard let viewModel = viewModel as? CoinListViewModel else{return}
        if let position = selectedCurrency, position < viewModel.items.count{
            viewModel.didSelectCurrency(currency: viewModel.items[position])
        }
    }
    
    

}

// MARK: Data Source
extension CoinListViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? CoinListViewModel else {return 0}
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinListTableViewCell.identifier, for: indexPath)
        
        if let cell = cell as? CoinListTableViewCell{
            guard let viewModel = viewModel as? CoinListViewModel else { return UITableViewCell()}
            cell.setupCell(item: viewModel.items[indexPath.row])
            let currentIndex = indexPath.row
            let selected = currentIndex == selectedCurrency
            cell.isSelected(selected)
        }
        return cell
    }
}

// MARK: - Delegate
extension CoinListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        updateSelectedIndex(indexPath.row)
        footerView.isHidden = false
        
    }
}

extension CoinListViewController: CoinListViewModelDisplayProtocol{
    func displayComponents() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

