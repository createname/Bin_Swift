//
//  RankingViewModel.swift
//  BinGuo
//
//  Created by wzy on 2019/9/23.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RankingViewModel: NSObject {
    var dataSource: BehaviorRelay<[[ListModel]]> = BehaviorRelay(value: [])
    private let bag = DisposeBag()
    
    func requestData() {
//        apiProvider.request(.rankingListApi) { (result) in
//            switch result {
//            case let .success(response):
//                do {
//                    
//                    
//                    let json = (try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? NSDictionary)
//                    print("dic======\(json ?? [:])===\(json?.value(forKey: "Message") ?? "")")
//                    
//                    
//                } catch {
//                    
//                }
//            case .failure(let error):
//                print(error)
//                
//            }
//        }
        
        let api = apiProvider.rx.request(.rankingListApi).map(RankModel.self, atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false).asObservable()
        api.subscribe(onNext: {[weak self] (rankModel) in
            var array = self?.dataSource.value
            array?.append(rankModel.Moneylist)
            array?.append(rankModel.Boylist)
            array?.append(rankModel.Girllist)
            array?.append(rankModel.Charmlist)
            array?.append(rankModel.Talentlist)
            self?.dataSource.accept(array!)
            
        }, onError: { (error) in
            print("error=======\(error.localizedDescription)")
        }, onCompleted: {
            
            }, onDisposed: {}).disposed(by: bag)
    }
}
