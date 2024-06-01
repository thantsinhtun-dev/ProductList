//
//  RootNCViewController.swift
//  Product
//
//  Created by Thant Sin Htun on 29/05/2024.
//

import UIKit

class RootNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.navigateToHome()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTokenExpired), name: .TokenExpiredNotification, object: nil)
    }
    
    @objc func handleTokenExpired() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error !", message: "Token Expired", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
        
    }
    func navigateToHome(){
        let tabbar = TabbarVC.init()
        pushViewController(tabbar, animated: true)
    }
}
