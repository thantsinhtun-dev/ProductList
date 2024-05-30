//
//  FavouriteVC.swift
//  Product
//
//  Created by Thant Sin Htun on 29/05/2024.
//

import UIKit

class FavouriteVC: UIViewController,StoryBoarded {
    static var storyboardName: StoryBoardHelper = .Home
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .heart),tag: 4)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
