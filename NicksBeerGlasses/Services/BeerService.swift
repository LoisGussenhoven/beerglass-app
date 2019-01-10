//
//  BeerService.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 13-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import Foundation
import SwiftyJSON

class BeerService : NSObject{
    
    static let baseUrl = "ROOT_URL" //TODO: change to host url
    
    /*
     * Log in to beerglass manager
     */
    static func logIn(username:String, password:String, onSuccess: @escaping (_ result: Int?) -> Void){
        var intResult = -2
        var result = ""
        let url = baseUrl + ":5000/api/auth"

        RequestHelper.get(url: url, username: username, password: password, callback: { (data) in
            result = String(data: data! as! Data, encoding: String.Encoding.utf8) ?? ""
            if result == "correct"{
                intResult = 1
            }else{
                intResult = -1
            }
            onSuccess(intResult)
        })
    }
    
    /*
     * Get request for photo from beerglass to API
     */
    static func getGlassPhoto(photo: String, onSuccess: @escaping (_ result: Data?) -> Void){
        let url = baseUrl + ":4200/resources/" + photo
        RequestHelper.get(url: url) { (data) in
            onSuccess(data as? Data)
        }
    }
    
    /*
     * Get request for getting all beerglasses from API
     */
    static func getBeerGlasses(onSuccess: @escaping (_ result: [BeerGlass]?) -> Void) {
        let url = baseUrl + ":5000/api/glass"
        RequestHelper.get(url: url) { (data) in
            let json = JSON(data)
            let beerGlasses = json.arrayValue.map({ (element) -> BeerGlass in
                let beerGlass = try? element.map(to: BeerGlass.self)
                return beerGlass!
            })
            onSuccess(beerGlasses)
        }
    }
}

extension JSON {
    
    /*
     * JSON builder from rawdata
     */
    public func map<T: Decodable>(to type: T.Type, with builder: ((JSONDecoder) -> Void)? = nil) throws -> T {
        let jsonDecoder = JSONDecoder()
        builder?(jsonDecoder)
        let data = try self.rawData()
        return try jsonDecoder.decode(type, from: data)
    }
}


