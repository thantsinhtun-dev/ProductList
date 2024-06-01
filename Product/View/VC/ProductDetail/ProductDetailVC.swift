//
//  ProductDetailVC.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import UIKit
import SDWebImage


class ProductDetailVC: UIViewController,StoryBoarded {
    static var storyboardName: StoryBoardHelper = .Home
    
    var productId : String = ""
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    lazy var vm: ProductDetailVM = ProductDetailVM(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initBindings()
        vm.fetchProductDetil(with: productId)
    }
    
    private func setupViews(){
        btnBack.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
    }
    
    private func initBindings(){
//        bindData()
    }
    @objc private func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
    private func bindData(productEntity : ProductEntity?){
        if let vo = productEntity {
            imgProduct.sd_setImage(
                with: URL(string: vo.thumbnail)
            )
            btnPrice.setTitle("$ \(vo.price)", for: .normal)
            lblDesc.text = vo.productDescription
            lblBrand.text = vo.brand
            lblTitle.text = vo.name
        }
    }

}

extension ProductDetailVC : ProductDetailViewDelegate {
    func onGetProductDetail() {
        bindData(productEntity: vm.productEntity)
    }
    
    func onGetError(message: String) {
        
    }
    
    
}
