//
//  ResponseModel.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation

protocol BaseResponse {
    var success: Bool {get set}
}

struct ResponseModel<T: Codable>: Codable, BaseResponse {
    
    
    // MARK: - Properties
    var success: Bool = false
    var message: String = ""
    var error: ErrorModel {
        return ErrorModel(message)
    }
    var rawData: Data?
    var data: T?
    var json: String? {
        guard let rawData = rawData else { return nil }
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?
    
    init() {}
}

// MARK: - Private Functions
extension ResponseModel {

    private enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}
