//
//  String+Extension.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
    
    
}
