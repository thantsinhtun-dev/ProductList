//
//  HomeVC.swift
//  Product
//
//  Created by Thant Sin Htun on 29/05/2024.
//

import UIKit

class HomeVC: UIViewController,StoryBoarded  {
    
    static var storyboardName: StoryBoardHelper = .Home

    @IBOutlet weak var cvProductList: UICollectionView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .home), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initBindings()
    }
    private func setupViews() {
        
        cvProductList.register(.init(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        cvProductList.delegate = self
        cvProductList.dataSource = self
        cvProductList.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    private func initBindings() {
        
    }
}

extension HomeVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell
        guard let cell = cell else { return UICollectionViewCell() }
        return cell
    }
}
extension HomeVC : UICollectionViewDelegate {
   
}

extension HomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width/2 - 16 - 8, height: collectionView.frame.height )
    }
}
