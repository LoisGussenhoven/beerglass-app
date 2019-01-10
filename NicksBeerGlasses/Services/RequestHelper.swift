//
//  RequestHelper.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 13-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import Foundation
import Alamofire

class RequestHelper{
    
    /*
     * Get request
     */
    static func get(url : String, callback: @escaping (_ result: Any?) -> Void){
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                if let data = response.data {
                    callback(data)
                } else {
                    callback(response.error?.localizedDescription ?? "Error")
                }
        }
    }
    
    /*
     * Log in request with basic authorization
     */
    static func get(url : String, username: String, password: String, callback: @escaping (_ result: Any?) -> Void){
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64LoginString)"]
        
        Alamofire.request(url, method: .get, headers: headers)
        .validate()
            .responseJSON { response in
                if let data = response.data {
                    callback(data)
                } else {
                    callback(response.error?.localizedDescription ?? "Error")
                }
            }
    }

}
