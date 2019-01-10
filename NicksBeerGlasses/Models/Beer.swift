//
//  Beer.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 14-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import Foundation

/*
 * Codable Beer model
 * Name, color
 */
class Beer : Codable{
    enum CodingKeys: String, CodingKey {
        case name
        case color
    }
    
    var name = ""
    var color = ""
    
    required init(_ builder: ((Beer) -> Void)? = nil) {
        builder?(self)
    }
    
    /*
     * Decodes current beer data if present
     */
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)!
        color = try container.decodeIfPresent(String.self, forKey: .color)!
        
    }
    
    /*
     * Encodes current beer data if present
     */
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(color, forKey: .color)
        
        
        var description: String {
            return "<Beer> [ name: \(name), color: \(color) ]"
        }
    }
}
