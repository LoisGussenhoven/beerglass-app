//
//  InfoViewController.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 10-12-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var logInButton: UITabBarItem!
    @IBOutlet weak var infoButton: UITabBarItem!
    @IBOutlet weak var favoritesButton: UITabBarItem!
    @IBOutlet weak var listButton: UITabBarItem!
    @IBOutlet weak var contactButton: UIButton!
    
    var email = "info_beerGlass@hotmail.nl"
    var tel = "0612345678"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setTabBar()
        _setNavigationBar()
    }
    
    private func _setNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 52/255, alpha: 1)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        title = "Info"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Hiragino Mincho ProN W6", size: 20)!]
    }

    @IBAction func contactButtonClicked(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Send messsage", message: "Send an e-mail or call us", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "E-mail", style: .default, handler: { (action: UIAlertAction) in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Phone", style: .default, handler: { (UIAlertAction) in
            self.call()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func call(){
        let number = URL(string: "tel://" + tel )
        UIApplication.shared.open(number!, options: [:], completionHandler: nil)
    }
    
    func sendEmail(){
        let email = URL(string: "mailto://" + self.email)
        UIApplication.shared.open(email!, options: [:], completionHandler: nil)
    }
}

extension InfoViewController : UITabBarDelegate{
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
