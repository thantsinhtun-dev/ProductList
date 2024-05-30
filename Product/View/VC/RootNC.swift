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

    func navigateToHome(){
        let tabbar = TabbarVC.init()
        pushViewController(tabbar, animated: true)
    }
}
