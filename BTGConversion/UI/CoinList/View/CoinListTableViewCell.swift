//
//  CoinListTableViewCell.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import UIKit

class CoinListTableViewCell: UITableViewCell {

    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var coinLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var identifier: String{
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupCell(item:CurrencyModel){
        coinLabel.text = item.initials
        valueLabel.text = item.name
    }
    
    
    public func isSelected(_ selected: Bool) {
        setSelected(selected, animated: false)
        self.accessoryType = selected ? .checkmark : .none
    }
    
}
