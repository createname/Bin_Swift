//
//  PageHeaderView.swift
//  BinGuo
//
//  Created by wzy on 2019/10/22.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

var segmentViewHeight: CGFloat { return 40 }

protocol UserPageSegmentViewDelegate: AnyObject {
    func pageSegment(selectedIndex index: Int)
}

class PageHeaderView: UIView {
    private var labels: [UILabel] = []
    private var indicateView: UIView!
    private var indicateViewCenterX:NSLayoutConstraint!
    private var currentTag: Int = 0

    public weak var delegate: UserPageSegmentViewDelegate?

    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.bottom.equalToSuperview()
        }
        
        indicateView = UIView()
        indicateView.backgroundColor = .red
        addSubview(indicateView)
        indicateView.translatesAutoresizingMaskIntoConstraints = false
        indicateView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        indicateView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        let titles = ["聊厂", "广场", "动态"]
        for (index, title) in titles.enumerated() {
            let titleLab = UILabel(text: title, font: .systemFont(ofSize: 16))
            labels.append(titleLab)
            stack.addArrangedSubview(titleLab)
            if index == currentTag {
                titleLab.textColor = .red
                titleLab.font = .boldSystemFont(ofSize: 16)
                indicateViewCenterX = indicateView.centerXAnchor.constraint(equalTo: titleLab.centerXAnchor)
                indicateViewCenterX.isActive = true
                indicateView.widthAnchor.constraint(equalTo: titleLab.widthAnchor, multiplier: 1.2).isActive = true
            } else {
                titleLab.textColor = .black
                titleLab.font = .systemFont(ofSize: 16)
            }
            titleLab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(tapGes:)))
            titleLab.addGestureRecognizer(tap)
        }
    }
    
    @objc func tapGestureHandler(tapGes: UITapGestureRecognizer) {
        
    }
    
    func setTitle(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        self.removeConstraint(indicateViewCenterX)
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        let totalDistance = targetLabel.centerX - sourceLabel.centerX
        
        self.removeConstraint(indicateViewCenterX)
        
        indicateViewCenterX = self.indicateView.centerXAnchor.constraint(equalTo: sourceLabel.centerXAnchor, constant: totalDistance * progress)
        indicateViewCenterX.isActive = true
        
        if progress == 1 {
            if sourceIndex == targetIndex {
                let currentLabel = labels[currentTag]
                currentLabel.textColor = .black
                currentLabel.font = .systemFont(ofSize: 16)
            } else {
                sourceLabel.textColor = .black
                sourceLabel.font = .systemFont(ofSize: 16)
            }
            targetLabel.textColor = .red
            targetLabel.font = .boldSystemFont(ofSize: 16)
            currentTag = targetIndex
        }
        
    }
}
