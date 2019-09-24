//
//  TopicCollectionViewCell.swift
//  BinGuo
//
//  Created by wzy on 2019/9/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell,CellBindViewModelProtocol {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var topLab: UILabel!
    @IBOutlet weak var bottomLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(with vm: CellViewModelProtocol) {
        guard let topicVM = vm as? TopicCellViewModel else {
            return
        }
        self.topLab.text = topicVM.topicMode.Title
        self.bottomLab.text = topicVM.topicMode.Desc
        
        let videoImgUrl = topicVM.getPicString(picString: topicVM.topicMode.Icon ?? "")

        self.imgView!.sd_setImage(with: URL(string: videoImgUrl), placeholderImage: UIImage(named: "guoguo_man"), completed: nil)
    }
}
