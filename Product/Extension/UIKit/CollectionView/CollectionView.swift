//
//  CollectionView.swift
//  helloworldinteraction
//
//  Created by Htet Yati Win on 16/03/2024.
//

import UIKit
import Foundation

extension UICollectionView {
    
    func registerCell<T: UITableViewCell>(ofType cell: T.Type) {
        self.register(.init(nibName: cell.identifier, bundle: .main), forCellWithReuseIdentifier: cell.identifier)
    }
    
    func deque<T: UICollectionViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { return UICollectionViewCell() }
        return cell
    }
}
