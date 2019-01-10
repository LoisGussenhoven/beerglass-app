//
//  BeerGlassManager.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 13-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import Foundation

class BeerGlassManager : NSObject {
    static let shared = BeerGlassManager()
    var currentFavorites: [BeerGlass] = [] {
        didSet {
            storeCurrentFavorites()
        }
    }
    var currentBeerGlasses: [BeerGlass] = [] {
        didSet {
            storeCurrentBeerGlasses()
        }
    }
    var currentBeerGlass: BeerGlass? {
        didSet {
            storeCurrentBeerGlass()
        }
    }
    
    func setUpFavorites(){
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "currentFavorites") {
            do {
                currentFavorites = try decoder.decode([BeerGlass].self, from: data)
            } catch let error {
                print("Error decodig beerglasses: \(error)")
            }
        }
    }
    
    func setUpBeerglasses(){
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "currentBeerGlasses") {
            do {
                currentBeerGlasses = try decoder.decode([BeerGlass].self, from: data)
            } catch let error {
                print("Error decodig beerglasses: \(error)")
            }
        }
    }
    
    func setUpBeerglass(){
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "currentBeerGlass") {
            do {
                currentBeerGlass = try decoder.decode(BeerGlass.self, from: data)
            } catch let error {
                print("Error decodig beerglass: \(error)")
            }
        }
    }
    
    func storeCurrentFavorites() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(currentFavorites)
            UserDefaults.standard.set(data, forKey: "currentFavorites")
            _ = UserDefaults.standard.synchronize()
            
        } catch let error {
            print("Error encoding storeCurrentFavorites: \(error)")
        }
    }
    
    func storeCurrentBeerGlasses() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(currentBeerGlasses)
            UserDefaults.standard.set(data, forKey: "currentBeerGlasses")
            _ = UserDefaults.standard.synchronize()
            
        } catch let error {
            print("Error encoding currentBeerGlasses: \(error)")
        }
    }
    
    func storeCurrentBeerGlass() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(currentBeerGlass)
            UserDefaults.standard.set(data, forKey: "currentBeerGlass")
            _ = UserDefaults.standard.synchronize()
            
        } catch let error {
            print("Error encoding currentBeerGlass: \(error)")
        }
    }
    
    deinit {
        print("DEALLOC \(self)")
    }
}
