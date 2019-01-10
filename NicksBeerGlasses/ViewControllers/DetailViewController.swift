//
//  DetailViewController.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 19-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var beerglassImageView: UIImageView!

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var beerslabel: UILabel!
    
    @IBOutlet weak var darkener: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        self.navigationItem.backBarButtonItem?.title = ""
        let play = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(playTapped))
        navigationItem.rightBarButtonItems = [play]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Hiragino Mincho ProN W6", size: 20)!]
        
        brandLabel.text = BeerGlassManager.shared.currentBeerGlass?.brand.name
        typeLabel.text = BeerGlassManager.shared.currentBeerGlass?.type.name
        BeerService.getGlassPhoto(photo: (BeerGlassManager.shared.currentBeerGlass?.photo)!) { (data) in
            DispatchQueue.main.async {
                let image =  UIImage(data: data!)
                image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 234))
                self.beerglassImageView.image = image
            }
        }
        
        var beers = ""
        for b in (BeerGlassManager.shared.currentBeerGlass?.beers)!{
            beers += b.name
            beers += " "
        }
        beerslabel.text = beers
        checkForFavorite()
        setFavorite()
        darkener.layer.opacity = 0.5
    }
    
    @objc func playTapped(){
        self.navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        favorite = !favorite
        setFavorite()
        if favorite{
            putInFavorite()
        }else{
            removeFromFavorite()
        }
    }
    
    func putInFavorite(){
        BeerGlassManager.shared.currentFavorites.append(BeerGlassManager.shared.currentBeerGlass!)
        BeerGlassManager.shared.storeCurrentFavorites()
    }
    
    func checkForFavorite(){
        let currentName = (BeerGlassManager.shared.currentBeerGlass?.brand.name)! + (BeerGlassManager.shared.currentBeerGlass?.type.name)!
        for bg in BeerGlassManager.shared.currentFavorites{
            let bgName = bg.brand.name + bg.type.name
           
            if bgName == currentName {
                favorite = true
                return
            }else{
                favorite = false
                
            }
        }
    }
    
    func removeFromFavorite(){
        let currentName = (BeerGlassManager.shared.currentBeerGlass?.brand.name)! + (BeerGlassManager.shared.currentBeerGlass?.type.name)!
        var count = 0
        for bg in BeerGlassManager.shared.currentFavorites{
            let bgName = bg.brand.name + bg.type.name
            if bgName == currentName {
                BeerGlassManager.shared.currentFavorites.remove(at: count)
                BeerGlassManager.shared.storeCurrentFavorites()
            }
            count += 1
        }
    }
    
    func setFavorite(){
        if favorite{
            favoriteButton.setImage(UIImage(named: "make_favorite_icon.png"), for: UIControl.State.normal)
        }else{
            favoriteButton.setImage(UIImage(named: "make_not_favorite_icon.png"), for: UIControl.State.normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = BeerGlassManager.shared.currentBeerGlass?.brand.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
    }
    
}
