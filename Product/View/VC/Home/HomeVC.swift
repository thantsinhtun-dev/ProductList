//
//  HomeVC.swift
//  Product
//
//  Created by Thant Sin Htun on 29/05/2024.
//

import UIKit

class HomeVC: UIViewController,StoryBoarded  {
    
    static var storyboardName: StoryBoardHelper = .Home
    lazy var vm: HomeVM = HomeVM(delegate: self)

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var btnSearch: UIButton!
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
        vm.fetchProductList()
    }
    private func setupViews() {
        
        cvProductList.register(.init(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        cvProductList.delegate = self
        cvProductList.dataSource = self
        cvProductList.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        loadingView.transform = CGAffineTransform.init(scaleX: 2, y: 2)

        btnSearch.addTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
    }
    private func initBindings() {
        
    }
    
    @objc private func onTapSearch(){
        let vc = SearchProductVC.ininstantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func showLoading(){
        loadingView.isHidden = false
        cvProductList.isHidden = true
    }
    private func hideLoading(){
        loadingView.isHidden = true
        cvProductList.isHidden = false
    }
}

extension HomeVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.setData(with: vm.productList[indexPath.row])
        guard let cell = cell else { return UICollectionViewCell() }
        return cell
    }
}
extension HomeVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailVC.ininstantiate()
        vc.productId = vm.productList[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width/2 - 16 - 8, height: 300 )
    }
}

extension HomeVC : HomeViewDelegate {
    func onGetProductList() {
        hideLoading()
        DispatchQueue.main.async {
            self.cvProductList.reloadData()
        }
    }
    
    func loading() {
        showLoading()
    }
    
    func onGetError(message: String) {
        print(message)
        hideLoading()
    }
    
    
}
