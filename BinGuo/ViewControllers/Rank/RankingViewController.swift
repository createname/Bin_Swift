//
//  RankingViewController.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RankingViewController: ZYBaseViewController {
    
    private let bag = DisposeBag()
    
    var rankVM: RankingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rankVM = RankingViewModel()
        rankVM.dataSource.subscribe(onNext: { [weak self](_) in
            print("=======:\(self?.rankVM.dataSource.value ?? [])")
        }).disposed(by: bag)
        rankVM.requestData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
