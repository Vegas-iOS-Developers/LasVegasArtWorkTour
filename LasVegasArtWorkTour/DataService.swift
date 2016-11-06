//
//  DataService.swift
//  TEST
//
//  Created by William Jones on 9/18/16.
//  Copyright © 2016 William Jones. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias DownloadComplete = () -> ()

class DataService {
    
    private var _url: String!
    private var _response: String!
    
    var url: String {
        return _url
    }
    
    var response: String {
        return _response
    }
    
    init(url: String) {
        self._url = url
        print("DataService.init()")
    }
    
    func downloadDetails(_ completed: @escaping DownloadComplete) {
        print("DataService.downloadDetails()")
        
        
        Alamofire.request(self.url, parameters: nil)
            .responseString { (response) in
                print("Response: \(response.result)")
                
                switch response.result {
                    case .success:
                        if let data = response.data {
                            let newStr = String(data: data, encoding: String.Encoding.utf8)
                            print("************************")
                            self._response = newStr
                            completed()

                        }
                    
                    case .failure(let error):
                        print(error)
                }
        }
        
    }
    
}






