//
//  TabbarVC.swift
//  Product
//
//  Created by Thant Sin Htun on 29/05/2024.
//

import UIKit

class TabbarVC: UITabBarController {
    
    var homeVC : HomeVC {
        HomeVC.ininstantiate()
    }
    var shoppingBagVC : ShoppingBagVC {
        ShoppingBagVC.ininstantiate()
    }
    var favouriteVC : FavouriteVC {
        FavouriteVC.ininstantiate()
    }
    var profileVC : ProfileVC {
        ProfileVC.ininstantiate()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: self.tabBar.bounds.minY + -10, width: self.tabBar.bounds.width - 60, height: self.tabBar.bounds.height + 10), cornerRadius: (self.tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.black.cgColor
        if let items = self.tabBar.items {
            items.forEach { item in
                item.titlePositionAdjustment = .init()
            }
        }
        self.tabBar.layer.insertSublayer(layer, at: 0)
        self.tabBar.itemWidth = 56.0
        self.tabBar.itemPositioning = .centered
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.lightGray.withAlphaComponent(0.7)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        viewControllers = [
            homeVC,favouriteVC,shoppingBagVC,profileVC
        ]
    }
    
}
