//
//  TopicCellViewModel.swift
//  BinGuo
//
//  Created by wzy on 2019/9/19.
//  Copyright © 2019 wzy. All rights reserved.
//
import Foundation
import UIKit
struct TopicCellViewModel: CellViewModelProtocol {
    func cellReuseIdentifier() -> String {
        return "TopicCollectionViewCell"
    }
    
    var topicMode: TopicModel
    
    func cellSize() -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width - 47)/2, height: (UIScreen.main.bounds.size.width - 50)/2/2)
    }
}
