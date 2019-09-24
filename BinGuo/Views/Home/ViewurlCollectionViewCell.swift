//
//  ViewurlCollectionViewCell.swift
//  BinGuo
//
//  Created by wzy on 2019/9/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class ViewurlCollectionViewCell: UICollectionViewCell,CellBindViewModelProtocol {

    var webView:WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView = WKWebView()
        contentView.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func bind(with vm: CellViewModelProtocol) {
        guard let viewurlVM = vm as? ViewurlCellViewModel else {
            return
        }
        let url = "\(viewurlVM.viewurlModel.url ?? "")?token=5093c9ab8e9f1eda42d85dea4b0056d6&sid=dec2aed966ea0b84a1da25f9ee760aa5b95cce89a346dae75a36c08efc9e36492402314f262d2f6833c23f07ac5c929e"
        let request = URLRequest(url: URL(string: url)!)

        webView.load(request)
    }

}
