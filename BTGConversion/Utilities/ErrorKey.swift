//
//  ErrorKey.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
enum ErrorKey: String {
    case general = "Ocorreu um erro ao processar a solicitação"
    case parsing = "Erro ao buscar os dados"
    case networkError = "Erro de conexão. Verifique sua internet"
}
