//
//  CoordinatorProtocol.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 21/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
