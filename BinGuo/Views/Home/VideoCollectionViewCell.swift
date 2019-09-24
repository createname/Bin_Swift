//
//  VideoCollectionViewCell.swift
//  BinGuo
//
//  Created by wzy on 2019/9/19.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class VideoCollectionViewCell: UICollectionViewCell, CellBindViewModelProtocol {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headIv: UIButton!
    @IBOutlet weak var nameLab: UILabel!
    
    
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(with vm: CellViewModelProtocol) {
        guard let videoVM = vm as? VideoCellViewModel else {
            return
        }
        let videoImgUrl = videoVM.getPicString(picString: videoVM.videoMode.Videoinfo?.thumbnail ?? "")
        
        let headImgUrl = videoVM.getPicString(picString: videoVM.videoMode.Userinfo?.icon ?? "")
        
        
        nameLab.text = videoVM.videoMode.Userinfo?.nickname
        
        imgView.sd_setImage(with: URL(string: videoImgUrl), placeholderImage: UIImage(named: "guoguo_man"), completed: nil)
        headIv.sd_setImage(with: URL(string: headImgUrl), for: .normal, placeholderImage: UIImage(named: "use_head-"), completed: nil)
        
        headIv.rx.controlEvent(.touchUpInside).subscribe(onNext: { (_) in
            print("点击来来来")
        }).disposed(by: bag)
        
       
    }
}
