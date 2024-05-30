//
//  Storyboarded.swift
//  Product
//
//  Created by Thant Sin Htun on 29/05/2024.
//

import Foundation
import UIKit

protocol StoryBoarded {
    static var storyboardName: StoryBoardHelper {get set}
    static func ininstantiate(bundle: Bundle) -> Self
}

extension StoryBoarded where Self:UIViewController{
    static func ininstantiate(bundle: Bundle = Bundle.main) -> Self {
        let storyboard = UIStoryboard.init(name: storyboardName.rawValue, bundle: bundle)
       return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
}
