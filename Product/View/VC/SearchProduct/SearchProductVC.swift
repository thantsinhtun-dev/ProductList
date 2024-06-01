//
//  SearchProductVC.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import UIKit

class SearchProductVC: UIViewController,StoryBoarded {
    
    static var storyboardName: StoryBoardHelper = .Home
    lazy var vm: SearchProductVM = SearchProductVM(delegate: self)

    

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var cvProductList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initBindings()
        
    }
    private func setupViews(){
        cvProductList.register(.init(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        cvProductList.delegate = self
        cvProductList.dataSource = self
        cvProductList.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        btnBack.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
        
        loadingView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        txtSearch.becomeFirstResponder()
        txtSearch.delegate = self
    }
    private func initBindings(){
    }
    @objc private func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func showLoading(){
        loadingView.isHidden = false
        cvProductList.isHidden = true
        emptyView.isHidden = true
    }
    
    private func showData(){
        loadingView.isHidden = true
        cvProductList.isHidden = false
        emptyView.isHidden = true
    }
    private func showError(){
        loadingView.isHidden = true
        cvProductList.isHidden = true
        emptyView.isHidden = false
    }
    

}

extension SearchProductVC : UICollectionViewDataSource {
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
extension SearchProductVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailVC.ininstantiate()
        vc.productId = vm.productList[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension SearchProductVC : UICollectionViewDelegateFlowLayout {
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

extension SearchProductVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let query = txtSearch.text {
            vm.searchProductList(with: query )
        }
        view.endEditing(true)
        return true
    }
}

extension SearchProductVC : SearchProductViewDelegate {
    func onGetProductList() {
        
        showData()
        DispatchQueue.main.async {
            self.cvProductList.reloadData()
        }
        
    }
    
    func onLoading() {
        showLoading()
    }
    
    func onGetError(message: String) {
        showError()
    }
    
    
}

