//
//  ZYTabBarViewController.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ZYTabBarViewController: UITabBarController {

    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var centerBtn: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(named: "find_n"), for: .normal)
        button.addTarget(self, action: #selector(tabBarItemSelect(button:)), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        button.frame = CGRect(x: 0, y: -2, width: self.bottomView.width, height: self.bottomView.height)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homNav = setChildViewController(vc: HomeViewController(), title: "首页", imgStr: "GuoGuo")
        let findNav = setChildViewController(vc: FindeViewController(), title: "", imgStr: "")
        let rankNav = setChildViewController(vc: RankingViewController(), title: "排行榜", imgStr: "Ranking List")
        self.viewControllers = [homNav, findNav, rankNav];
        
        setTabBarItem()
    }
    
    

}

extension ZYTabBarViewController{
    
    func setChildViewController(vc: UIViewController, title: String, imgStr: String) -> ZYNavigationViewController {
        vc.title = title;
        vc.tabBarItem.image = UIImage(named: imgStr+"_n")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imgStr+"_s")?.withRenderingMode(.alwaysOriginal)
        let nav = ZYNavigationViewController(rootViewController: vc)
        
        return nav
    }
    
    func setTabBarItem() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor("0x999999")!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor("0x333333")!], for: .selected)
        
        UITabBar().shadowImage = UIImage()
        UITabBar().backgroundColor = UIColor.white
        UITabBar().isTranslucent = false
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0.6))
        line.backgroundColor = UIColor("0xCCCCCC")
        self.tabBar.addSubview(line)
        
        self.bottomView.removeSubviews()
        self.bottomView.frame = CGRect(x: screenWidth()*0.4, y: -8, width: screenWidth()*0.2, height: 49+8)
        
        self.bottomView.addSubview(self.centerBtn)
        
        self.tabBar.addSubview(self.bottomView)
        
        self.tabBar.bringSubviewToFront(self.bottomView)
    }
    
    @objc func tabBarItemSelect(button:UIButton){
        self.selectedIndex = button.tag
    }
}
