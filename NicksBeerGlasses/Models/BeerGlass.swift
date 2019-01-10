//
//  BeerGlassManager.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 13-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import Foundation

/*
 * Codable beerglass model
 * Beers, brand, type, createDate, id, photo url
 */
class BeerGlass: Codable, CustomStringConvertible {
    enum CodingKeys: String, CodingKey {
        case beers
        case brand
        case type
        case createDate = "created"
        case id
        case photo = "url"
    }
    
    var beers : [Beer] = []
    var brand = Brand()
    var createDate = ""
    var id = ""
    var type = Type()
    var photo = ""
    
    required init(_ builder: ((BeerGlass) -> Void)? = nil) {
        builder?(self)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            brand = try container.decodeIfPresent(Brand.self, forKey: .brand)!
            createDate = try container.decodeIfPresent(String.self, forKey: .createDate)!
            id = try container.decodeIfPresent(String.self, forKey: .id)!
            type = try container.decodeIfPresent(Type.self, forKey: .type)!
            photo = try container.decodeIfPresent(String.self, forKey: .photo)!
            do{
                beers = try container.decodeIfPresent([Beer].self, forKey: .beers)!
            }catch{
                print("ERROR DECODING: \(error)")
            }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(beers, forKey: .beers)
        try container.encodeIfPresent(brand, forKey: .brand)
        try container.encodeIfPresent(createDate, forKey: .createDate)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(photo, forKey: .photo)
    }
    
    var description: String {
        return "<Beerglas> [ brand: \(brand.name), type: \(type.name) ]"
    }
}

/*
 * Codable model Brand
 * Id, name
 */
struct Brand : Codable{
    var id = ""
    var name = ""
}

/*
 * Codable model Type
 * Id, name
 */
struct Type : Codable{
    var id = ""
    var name = ""
}

