//
//  DataService.swift
//  TEST
//
//  Created by William Jones on 9/18/16.
//  Copyright © 2016 William Jones. All rights reserved.
//

import Foundation
import Alamofire

enum DataServiceResponse {
    case success(value: [[String: Any]])
    case failure(error: DataServiceError)
}

enum DataServiceError: Error {
    case apiError(msg: String)
    case httpError(msg: String, code: NSInteger?)
    case invalidResponseError(msg: String)
}

typealias DownloadComplete = (DataServiceResponse) -> (Void)

class DataService {
    
    private var _response: DataServiceResponse?
    
    internal var response: DataServiceResponse? {
        return _response
    }

    internal func download(from url: String, completionHander: @escaping DownloadComplete) {
        
        _response = nil
        
        Alamofire.request(url)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let validatedResponse = self._validate(response: value)
                    self._response = validatedResponse
                    completionHander(validatedResponse)
                    
                case .failure(let error):
                    
                    let statusCode = response.response?.statusCode
                    let message = error.localizedDescription
                    let httpError = DataServiceError.httpError(msg: message, code: statusCode)
                    
                    let response = DataServiceResponse.failure(error: httpError)
                    self._response = response
                    completionHander(response)
                }
        }
    }
    
    private func _validate(response: Any) -> DataServiceResponse {
        
        // If the response is an array of dictionaries, then its a valid response
        if let data = response as? [[String: Any]] {
            return DataServiceResponse.success(value: data)
        }
            
        // If the data is just a dictionary we need to check for errors returned by the API
        else if let data = response as? [String: Any] {
            if let apiError = self._extractAPIErrorFrom(data) {
                return DataServiceResponse.failure(error: apiError)
            }
            
            // If there isn't an API Error, its most likey a valid response
            // with only one item. Lets wrap it in an array so it looks like other valid responses
            return DataServiceResponse.success(value: [data])
        }
            
        // If the response is anything else, we don't understand it. Return an error
        else {
            let invalidResponseError = DataServiceError.invalidResponseError(msg: "Unable to process response.")
            return DataServiceResponse.failure(error: invalidResponseError)
        }
    }
    
    private func _extractAPIErrorFrom(_ response: [String: Any]) -> DataServiceError? {
        
        // checks for the "error" key in the response
        // If it is set to true, then extract the error message
        // and return an error with that message
        if let apiErrorPresent = response["error"] as? Bool {
            if apiErrorPresent {
                var message = "API Error"
                if let apiErrorMessage = response["message"] as? String {
                    message = apiErrorMessage
                }
                return DataServiceError.apiError(msg: message)
            }
        }
        
        // No error has been found, so lets return nil
        return nil
    }
}






