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
import Alamofire

class RankingViewModel: NSObject {
    var dataSource: BehaviorRelay<[[ListModel]]> = BehaviorRelay(value: [])
    private let bag = DisposeBag()
    
    func requestData(error: (_ error:Error)->()) {
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

extension RankingViewModel{
    func goToLogin() {
        let pwd = "123456789";
        let data = pwd.data(using: .utf8)
        let str = data?.base64EncodedString(options: .lineLength64Characters)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let time = dateFormatter.string(from: Date.init())
        print("str===\(str!)===time==\(time)")
        Alamofire.request("https://app.tomatoim.com/users/login/info", method: .post, parameters: ["user":"13699764048","upwd":str ?? "","ptoken":""], encoding: URLEncoding.default, headers: ["Authorization":"13699764048$"+time,"User-Agent":"Mozilla/5.0(Platform/iPhone; Brand/bingo; Version/2.6.6; Language/en; Channels/0; Category/0; OS/unpb_13.0; Model/iPhone_Simulator)"]).responseJSON { (response) in
            guard response.result.isSuccess else {return}
            if let json = response.result.value as? [String : Any]{
                
                print("response=====\(response)====mest=\(String(describing: json["Message"]))")
            }
        }
    }
    
    
    public func getRankList(completionHander: @escaping(_ dic:[String: Any])->()) {
        let url = "https://app.tomatoim.com/users/top"
        
        let headers = [

            "User-Agent":"Mozilla/5.0(Platform/iPhone; Brand/bingo; Version/2.6.6; Language/en; Channels/0; Category/0; OS/unpb_13.0; Model/iPhone_Simulator)",
        
            "BINGO-TOKEN":"1d6b2ebb2a286782141864ad51f578a7",
        "BINGO-USERID":"ade2e1ff2a3a3e3cc349d60a27a1d78c67b4c527125e8a5ea1f11870ab7614b4",
        "Authorization":"DF25DFE9-D743-4424-B108-BDC0BB9C1C97$13699764048"
        ]
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            guard response.result.isSuccess else
            {
                print("请求失败=====\(response)")
                return
            }
            
            if let json = response.result.value as? [String:Any]{
                print("value======\(json["Message"] as! String)")
            }
        }
        
    }
}
