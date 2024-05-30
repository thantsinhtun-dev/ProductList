//
//  HomeVC.swift
//  Product
//
//  Created by Thant Sin Htun on 29/05/2024.
//

import UIKit

class HomeVC: UIViewController,StoryBoarded  {
    static var storyboardName: StoryBoardHelper = .Home

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .home), tag: 3)
//        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // Center icon
//        let secondTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 1)
//        secondTabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0) // Center icon
//                self.tabBarItem = secondTabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
