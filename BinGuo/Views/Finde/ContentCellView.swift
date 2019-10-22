//
//  ContentCellView.swift
//  BinGuo
//
//  Created by wzy on 2019/10/22.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

public protocol ContainScrollView: UIViewController{
    func scrollView() -> UIScrollView
    
    func scrollViewDidScroll(callBack: @escaping (UIScrollView)->())
}

protocol ContentCellViewDataSource: AnyObject {
    func numberOfViewController() -> Int
    
    func viewController(itemAt indexPath: IndexPath) -> UIViewController
    
    func collectionViewScroll(progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

class ContentCellView: UIView {
    public weak var delegate: ContentCellViewDataSource?
    
    public weak var hostScrollView: UIScrollView!
    
    var startScrollOffsetX: CGFloat = 0
    
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchPage(index: Int) {
           collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: false)
       }
    
    private func setupUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = bounds.size
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}

extension ContentCellView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return bounds.size
    }
}

extension ContentCellView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfViewController() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let vc = delegate?.viewController(itemAt: indexPath) else {
            return cell
        }
        vc.view.frame = cell.bounds
        cell.contentView.removeSubviews()
        cell.contentView.addSubview(vc.view)
        return cell
    }
    
   
}

extension ContentCellView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.hostScrollView.isScrollEnabled = true
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.hostScrollView.isScrollEnabled = true
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.hostScrollView.isScrollEnabled = true
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startScrollOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking || scrollView.isDecelerating {
            self.hostScrollView.isScrollEnabled = false
        }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        
        if startScrollOffsetX > currentOffsetX {//右滑动
            progress = 1 - (currentOffsetX / width - floor(currentOffsetX / width))
            targetIndex = Int(currentOffsetX / width)
            sourceIndex = targetIndex + 1
            if sourceIndex >= delegate?.numberOfViewController() ?? 1 {
                sourceIndex = (delegate?.numberOfViewController() ?? 1)-1
            }
        } else {//左滑动
            progress = currentOffsetX / width - floor(currentOffsetX / width)

            sourceIndex = Int(currentOffsetX / width)
            targetIndex = sourceIndex + 1
            if targetIndex >= delegate?.numberOfViewController() ?? 1 {
                targetIndex = (delegate?.numberOfViewController() ?? 1)-1
            }
            if currentOffsetX - startScrollOffsetX == width {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        
        delegate?.collectionViewScroll(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
