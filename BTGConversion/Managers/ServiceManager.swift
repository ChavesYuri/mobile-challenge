//
//  ServiceManager.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
class ServiceManager {
    
    // MARK: - Properties
    public static let shared: ServiceManager = ServiceManager()
    
    public var baseURL: String = "http://api.currencylayer.com"
}

// MARK: - Public Functions
extension ServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
        if request.isLoggingEnabled.0 {
            LogManager.req(request)
        }
        
      
        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain, error.code == NSURLErrorNotConnectedToInternet{
                    completion(Result.failure(ErrorModel.networkError()))
                }else{
                    let err: ErrorModel = ErrorModel(error.localizedDescription)
                    completion(Result.failure(err))
                }
            }
            
            guard let data = data, let response = try? JSONDecoder().decode(T.self, from: data) else {
                let err: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                completion(Result.failure(err))
                return
            }
            
            var responseModel = ResponseModel<T>()
            responseModel.rawData = data
            responseModel.data = response
            responseModel.request = request
            if let validate = response as? BaseResponse{
                responseModel.success = validate.success
            }

            if request.isLoggingEnabled.1 {
                LogManager.res(responseModel)
            }
        
            if responseModel.success{
                completion(Result.success(response))
            } else {
                completion(Result.failure(ErrorModel.generalError()))
            }

        }.resume()
    }
}
