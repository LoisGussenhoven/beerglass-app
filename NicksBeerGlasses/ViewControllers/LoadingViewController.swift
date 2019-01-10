//
//  LoadingViewController.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 13-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var titleText = "Nick's beerglasses"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText

        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
        
        getBeerGlasses()
        
        self.navigationController?.isNavigationBarHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            let transition = CATransition()
            transition.duration = 1
            self.navigationController?.view.layer.add(transition, forKey: nil)
            let svc = MainViewController()
            self.navigationController?.pushViewController(svc, animated: false)
        })
    }
    
    
    func getBeerGlasses(){
        BeerGlassManager.shared.currentBeerGlasses.removeAll()
        BeerService.getBeerGlasses(onSuccess: {(resultBeerGlasses) in
            for b in resultBeerGlasses!{
                BeerGlassManager.shared.currentBeerGlasses.append(b)
            }
            BeerGlassManager.shared.storeCurrentBeerGlasses()
       })
    }

}
