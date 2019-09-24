//
//  VideoCellViewModel.swift
//  BinGuo
//
//  Created by wzy on 2019/9/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation
import UIKit


struct VideoCellViewModel: CellViewModelProtocol {
    var videoMode: VideoModel
    
    func cellReuseIdentifier() -> String {
        return "VideoCollectionViewCell"
    }
    
    
    func cellSize() -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width - 40)/3, height: 380 - 105 - 60 - 3)
    }
    
   
}
