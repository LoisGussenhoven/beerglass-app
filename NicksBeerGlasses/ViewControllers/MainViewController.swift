//
//  MainViewController.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 13-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var beerTable: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var logInButton: UITabBarItem!
    @IBOutlet weak var infoButton: UITabBarItem!
    @IBOutlet weak var favoritesButton: UITabBarItem!
    @IBOutlet weak var listButton: UITabBarItem!
    
    var beerGlassNames : [String] = []
    var filteredBeerGlassesNames : [String] = []
    var isSearching = false
    var show = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setSearchBar()
        _setTableView()
        _setNavigationBar()
        _setTabBar()
    }
   
    func setDetailModel(beerglass : BeerGlass){
        BeerGlassManager.shared.setUpBeerglass()
        BeerGlassManager.shared.currentBeerGlass = BeerGlass()
        BeerGlassManager.shared.currentBeerGlass?.brand = beerglass.brand
        BeerGlassManager.shared.currentBeerGlass?.type = beerglass.type
        BeerGlassManager.shared.currentBeerGlass?.createDate = beerglass.createDate
        BeerGlassManager.shared.currentBeerGlass?.id = beerglass.id
        BeerGlassManager.shared.currentBeerGlass?.photo = beerglass.photo
        for b in beerglass.beers{
            BeerGlassManager.shared.currentBeerGlass?.beers.append(b)
        }
        BeerGlassManager.shared.storeCurrentBeerGlass()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Beers"
    }
    
    private func _setNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 52/255, alpha: 1)
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Hiragino Mincho ProN W6", size: 20)!]
    }
}

extension MainViewController : UITabBarDelegate{

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "MANAGER"{
            let vc = UserDefaults.standard.bool(forKey: "loggedIn") ? ManagerViewController() : LogInViewController()
            self.navigationController?.pushViewController(vc, animated: false)            
        }else if item.title == "GLASSES"{
            self.navigationController?.pushViewController(MainViewController(), animated: false)
            
        }else if item.title == "FAVORITES"{
            self.navigationController?.pushViewController(FavoritesViewController(), animated: false)
            
        }else if item.title == "INFO"{
            self.navigationController?.pushViewController(InfoViewController(), animated: false)
        }
    }
    
    private func _setTabBar(){
        tabBar.delegate = self
    }
}


extension MainViewController : UITableViewDataSource, UITableViewDelegate{
    private func _setTableView(){
        beerTable.delegate = self
        beerTable.dataSource = self
        self.beerTable.reloadData()
        
        for b in BeerGlassManager.shared.currentBeerGlasses{
            beerGlassNames.append(b.brand.name + " " + b.type.name)
        }
        
        beerTable.dataSource = self
        self.beerTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return filteredBeerGlassesNames.count
        }
        return beerGlassNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tableViewCell")
            cell!.accessoryType = .disclosureIndicator
        }
        
        var text = ""
        if isSearching {
            text = filteredBeerGlassesNames[indexPath.row]
        }else{
            text = beerGlassNames[indexPath.row]
        }
        
        cell!.textLabel?.text = text
        for b in BeerGlassManager.shared.currentBeerGlasses{
            var detailtext = ""
            if (b.brand.name + " " + b.type.name) == text{
                for c in b.beers{
                    detailtext += c.name
                    detailtext += " "
                }
                cell!.detailTextLabel?.text = detailtext
            }
        }
    
        cell?.detailTextLabel?.font = UIFont(name: "Hiragino Mincho ProN W6", size: 11)
        cell?.textLabel?.font = UIFont(name: "Hiragino Mincho ProN W6", size: 15)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        let currentItem = currentCell.textLabel!.text
        toDetailView(currentItem: currentItem!)
    }
    
    func toDetailView(currentItem : String){
        for b in BeerGlassManager.shared.currentBeerGlasses{
            let beerglassName = b.brand.name + " " + b.type.name
            if currentItem == beerglassName{
                setDetailModel(beerglass: b)
                let svc = DetailViewController()
                navigationController?.pushViewController(svc, animated: true)
            }
        }
    }
}

extension MainViewController : UISearchBarDelegate{
    private func _setSearchBar(){
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor(displayP3Red: 40/255, green: 40/255, blue: 52/255, alpha: 1).cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        searchBar.delegate = self
        self.searchBar.isTranslucent = false
        self.searchBar.backgroundImage = image
        searchBar.barTintColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 52/255, alpha: 1)
        searchBar.layer.borderColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 52/255, alpha: 1).cgColor
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            beerTable.reloadData()
        }else{
            isSearching = true
            filteredBeerGlassesNames = beerGlassNames.filter({$0.contains(searchBar.text as! String) || $0.lowercased().contains(searchBar.text as! String)})
            beerTable.reloadData()
        }
    }
}
