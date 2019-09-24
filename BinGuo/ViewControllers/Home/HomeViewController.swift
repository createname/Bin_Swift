//
//  HomeViewController.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import MJRefresh

class HomeViewController: ZYBaseViewController {
    
    var homeVM: HomeListViewModel!
    
    private var collectionView: UICollectionView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        homeVM = HomeListViewModel()
        homeVM.requestData()
        homeVM.dataSource.subscribe(onNext: { [weak self](_) in
            self?.collectionView.mj_header.endRefreshing()
            self?.collectionView.reloadData()
        }).disposed(by: bag)
    }
    
}

extension HomeViewController{
    func setupUI() {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "VideoCollectionViewCell")
        collectionView.register(UINib(nibName: "TopicCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TopicCollectionViewCell")
        collectionView.register(UINib(nibName: "ViewurlCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ViewurlCollectionViewCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.homeVM.requestData()
        })
        
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
//            guard _ = homeVM.viewurlViewModel as! _ else { return 0}
            return 1
        case 1:
            return homeVM.videoDataSource.count
        case 2:
            return homeVM.topicDataSource.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellViewModel: CellViewModelProtocol
        
        switch indexPath.section {
        case 0:
            cellViewModel = homeVM.viewurlViewModel
        case 1:
            cellViewModel = homeVM.videoDataSource[indexPath.item]
            
        default:
            cellViewModel = homeVM.topicDataSource[indexPath.item]
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellReuseIdentifier(), for: indexPath)
        
        (cell as! CellBindViewModelProtocol).bind(with: cellViewModel)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellViewModel: CellViewModelProtocol
        switch indexPath.section {
        case 0:
            cellViewModel = homeVM.viewurlViewModel
        case 1:
            cellViewModel = homeVM.videoDataSource[indexPath.item]
        default:
            cellViewModel = homeVM.topicDataSource[indexPath.item]
            
        }
        return cellViewModel.cellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 5
        default:
            return 10
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
