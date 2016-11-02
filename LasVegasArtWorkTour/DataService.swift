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
    
    func downloadDetails(completed: DownloadComplete) {
        print("DataService.downloadDetails()")
        
        Alamofire.request(.GET, self.url, parameters: nil)
            .responseString { (response) in
                
                switch response.result {
                case .Success:
                    if let data = response.data {
                        //let newStr = String(data: data, encoding: String.Encoding.utf8)
                        //print("data: \(data)")
                        print("************************")
                        let newStr = String(data: data, encoding: NSUTF8StringEncoding)
                        self._response = newStr
                        //print("self._response: \(self._response)")
                        
                        completed()
                    }
                    
                case .Failure(let error):
                    print(error)
                }
             
        }
        
    }
    
}






