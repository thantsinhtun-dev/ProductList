//
//  TextField.swift
//  helloworldinteraction
//
//  Created by Htet Yati Win on 03/03/2024.
//

import Foundation
import UIKit

extension Array where Element == UITextField? {
    func addTarget(for vc: UIViewController, action: Selector) {
        self.compactMap {
            $0
        }.forEach {
            $0.addTarget(vc, action: action, for: .editingChanged)
        }
        
    }
}
