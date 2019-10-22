//
//  DetailViewController.swift
//  BinGuo
//
//  Created by wzy on 2019/10/17.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    fileprivate var didScroll: ((UIScrollView) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension DetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "哈哈哈"
        return cell!
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView)
    }
}

extension DetailViewController: ContainScrollView {
    func scrollView() -> UIScrollView {
        return tableView
    }
    
    func scrollViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        didScroll = callBack
    }
}
