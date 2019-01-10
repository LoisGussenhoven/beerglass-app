//
//  LogInViewController.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 10-12-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var logInButton: UITabBarItem!
    @IBOutlet weak var infoButton: UITabBarItem!
    @IBOutlet weak var favoritesButton: UITabBarItem!
    @IBOutlet weak var listButton: UITabBarItem!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
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
        title = "Manager"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Hiragino Mincho ProN W6", size: 20)!]
    }

    
    @IBAction func logInTapped(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        BeerService.logIn(username: username ?? "", password: password ?? "") { (intResult) in
            if intResult == 1 {//Correct
                DispatchQueue.main.async {
                    UserDefaults.standard.bool(forKey: "loggedIn")
                    UserDefaults.standard.set(true, forKey: "loggedIn")
                    self.navigationController?.pushViewController(ManagerViewController(), animated: true)
                }
            }else if intResult == -2{//Default
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Something went wrong", message: "Please try again later", preferredStyle:.alert)
                    let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action1)
                    self.present(alertController, animated: true, completion: nil)
                }
            }else{//Action not allowed
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Acces is denied", message: "Username and/or password is wrong", preferredStyle:.alert)
                    let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action1)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}



extension LogInViewController : UITabBarDelegate{
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
  
