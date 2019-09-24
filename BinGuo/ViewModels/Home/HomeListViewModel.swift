//
//  HomeListViewModel.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

class HomeListViewModel: NSObject {

    var dataSource: BehaviorRelay<HomeModel> = BehaviorRelay(value: HomeModel())
    
    
    var topicDataSource: [CellViewModelProtocol]{
        return dataSource.value.Topic.map({ (topicModel) -> CellViewModelProtocol in
            TopicCellViewModel(topicMode: topicModel)
        })
    }
    
    var videoDataSource: [CellViewModelProtocol]{
        return dataSource.value.Video.map({ (videoModel) -> CellViewModelProtocol in
            VideoCellViewModel(videoMode: videoModel)
        })
    }
    
    var viewurlViewModel: CellViewModelProtocol{
        return ViewurlCellViewModel(viewurlModel: dataSource.value.Viewurl ?? ViewurlModel())
    }
    
    private var bag = DisposeBag()
    
    public func requestData() {
        requestList(page: 0).subscribe(onNext: { [weak self](homeModel) in
            if let strongSelf = self{
                strongSelf.dataSource.accept(homeModel)

            }
//            print("model.linek====\(homeModel.Likeuser)")
        }, onError: { error in
//            DispatchQueue.main.async {
//                complete(error)
//            }
        }, onCompleted: {
//            DispatchQueue.main.async {
//                complete(nil)
//            }
        }, onDisposed: {}).disposed(by: bag)
    }
    
    private func requestList(page: Int) -> Observable<HomeModel> {
//        apiProvider.request(.homeListApi(limit: 20, offset: page)) { (result) in
//            switch result {
//            case let .success(response):
//                do {
//
//
//                    let json = (try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? NSDictionary)
//                    print("dic======\(json ?? [:])===\(json?.value(forKey: "Message") ?? "")")
//
////                    let decoder = JSONDecoder()
////                    let home = try decoder.decode(HomeModel.self, from: self.jsonToData(jsonDic: json as! Dictionary<String, Any>)!)
////
////                    print("home=======\(home)")
//
//                } catch {
//                    print("MoyaError.jsonMapping(result) = \(MoyaError.jsonMapping(response))")
//                }
//            case .failure(let error):
//                print(error)
//
//            }
//        }

        return apiProvider.rx.request(.homeListApi(limit: 20, offset: page)).map(HomeModel.self, atKeyPath: "Values", using: JSONDecoder(), failsOnEmptyData: false).asObservable()
        
    }
    
    /// 字典转data
    func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
        
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            
            print("is not a valid json object")
            
            return nil
            
        }
        
        //利用自带的json库转换成Data
        
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        
        //Data转换成String打印输出
        
        let str = String(data:data!, encoding: String.Encoding.utf8)
        
        //输出json字符串
        
        print("Json Str:\(str!)")
        
        return data
        
    }
}

