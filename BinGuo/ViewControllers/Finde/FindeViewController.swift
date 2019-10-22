//
//  FindeViewController.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

open class MainTableView: UITableView{
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let view = otherGestureRecognizer.view else {
            return false
        }
        if view is UIScrollView {
            return true
        }
        return false
    }
}

class FindeViewController: ZYBaseViewController {
    private var isHostScrollViewEnable = false
    private var isContainScrollViewEnable = false

    var tableView: MainTableView!
    var childVCs: [ContainScrollView] = []
    private var contentView: ContentCellView!
    private var titleView: PageHeaderView!
    private var naviHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height + 44
    }
    
    private var headerViewHeight: CGFloat {
        return 280
    }
    
    private var stopScrollOffset: CGFloat {
        return headerViewHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "发现"
        setupUI()
    }
    

    
}

extension FindeViewController{
    
    func setupUI() {

        self.tableView = MainTableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth(), height: headerViewHeight))
        view.addSubview(self.tableView)
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        contentView = ContentCellView()
        contentView.hostScrollView = self.tableView
        
        for index in 0..<3 {
            let vc = DetailViewController()
            childVCs.append(vc)
        }
        
        childVCs.forEach { (vc) in
            addChild(vc)
            vc.scrollViewDidScroll { [weak self](scrollView) in
                self?.containScrollViewDidScroll(scrollView)
            }
        }

    }
}

extension FindeViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height - naviHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        titleView = PageHeaderView()
        titleView.backgroundColor = .groupTableViewBackground
        titleView.delegate = self
        return titleView
    }
}

extension FindeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell?.backgroundColor = .groupTableViewBackground
            contentView.delegate = self
            cell?.contentView.addSubview(contentView)
            contentView.frame = CGRect(x: 0, y: 0, width: screenWidth(), height: view.height - naviHeight - segmentViewHeight - view.safeAreaInsets.bottom)
        }
        
        return cell!
    }
}
extension FindeViewController{
    func containScrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > 0 {//向上滑动
            if isContainScrollViewEnable {
                scrollView.showsVerticalScrollIndicator = true
                
                if tableView.contentOffset.y == 0 {
                    isHostScrollViewEnable = true
                    isContainScrollViewEnable = false
                    
                    scrollView.contentOffset = .zero
                    scrollView.showsVerticalScrollIndicator = false
                } else {
                    tableView.contentOffset = CGPoint(x: 0, y: stopScrollOffset)
                }
            } else {
                scrollView.contentOffset = CGPoint.zero
                scrollView.showsVerticalScrollIndicator = false
            }
        } else {//向下滑动
            isContainScrollViewEnable = false
            isHostScrollViewEnable = true
//            scrollView.contentOffset = CGPoint.zero
            scrollView.showsVerticalScrollIndicator = false

        }
    }
}
extension FindeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        //判断是否可以继续向上滑动
        if offsetY >= stopScrollOffset {

            tableView.showsVerticalScrollIndicator = false
            scrollView.contentOffset.y = stopScrollOffset
            if isHostScrollViewEnable {
                isHostScrollViewEnable = false
                isContainScrollViewEnable = true
            }
        } else {
            
            if isContainScrollViewEnable {
                print("isContainScrollViewEnable是yes")
                scrollView.contentOffset.y = stopScrollOffset
            }
        }
        
    }
}

extension FindeViewController: UserPageSegmentViewDelegate{
    func pageSegment(selectedIndex index: Int) {
        contentView.switchPage(index: index)
    }
}

extension FindeViewController: ContentCellViewDataSource{
    func viewController(itemAt indexPath: IndexPath) -> UIViewController {
        return childVCs[indexPath.item]
    }
    
    func collectionViewScroll(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {

        titleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func numberOfViewController() -> Int {
        return childVCs.count
    }
    
}
