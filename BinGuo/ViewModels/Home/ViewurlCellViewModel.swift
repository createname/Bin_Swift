//
//  ViewurlCellViewModel.swift
//  BinGuo
//
//  Created by wzy on 2019/9/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation
import UIKit
struct ViewurlCellViewModel: CellViewModelProtocol {
    func cellReuseIdentifier() -> String {
        return "ViewurlCollectionViewCell"
    }
    
    var viewurlModel: ViewurlModel
    
    func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width-20, height: 120)
    }
    

}
