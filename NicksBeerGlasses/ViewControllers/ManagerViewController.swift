//
//  ManagerViewController.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 18-12-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var logInButton: UITabBarItem!
    @IBOutlet weak var infoButton: UITabBarItem!
    @IBOutlet weak var favoritesButton: UITabBarItem!
    @IBOutlet weak var listButton: UITabBarItem!

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setTabBar()
        self.navigationItem.hidesBackButton = true
        _setWebView()
        title = "Manager"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Hiragino Mincho ProN W6", size: 20)!]
    }
    
    private func _setWebView(){
        let url = URL(string: "http://google.nl")
        webView.loadRequest(URLRequest(url: url!))
    }
}

extension ManagerViewController : UITabBarDelegate{
    
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
