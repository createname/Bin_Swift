//
//  ZYNavigationViewController.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

class ZYNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let interactive = interactivePopGestureRecognizer else {
            return
        }
        guard let interactivePopView = interactive.view else {
            return
        }
        
        guard let target = interactive.delegate else {
            return
        }
        
        let action = Selector(("handleNavigationTransition:"));
        
        let pan = UIPanGestureRecognizer()
        pan.addTarget(target, action: action)
        pan.delegate = self
        interactivePopView.addGestureRecognizer(pan)
        
        navigationBar.barTintColor = UIColor("0xfbfbfb")
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor("0x333333")!, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
    }

}

extension ZYNavigationViewController: UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count <= 1 {
            return false
        }
        
        if (self.value(forKey: "_isTransitioning") as? Bool ?? false) {
            return false
        }
        
        let translation = gestureRecognizer.location(in: gestureRecognizer.view)
        if translation.x <= 0 {
            return false
        }
        
        return true
        
    }
}

extension UIScrollView: UIGestureRecognizerDelegate{
    // 当UIScrollView在水平方向滑动到第一个时，默认是不能全屏滑动返回的，通过下面的方法可实现其滑动返回。
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if panBack(gestureRecognizer: gestureRecognizer) {
            return false
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if panBack(gestureRecognizer: gestureRecognizer) {
            return true
        }
        return false
    }
    
    func panBack(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            let point = self.panGestureRecognizer.translation(in: self)
            let state = gestureRecognizer.state
            
            //设置手势滑动的位置距屏幕左边的区域
            let locationDistance = UIScreen.main.bounds.size.width
            
            if state == UIGestureRecognizer.State.began || state == UIGestureRecognizer.State.possible{
                let location = gestureRecognizer.location(in: self)
                if point.x > 0 && location.x < locationDistance && self.contentOffset.x <= 0 {
                    return true
                }
                
            }
            
        }
        return false
    }
}
