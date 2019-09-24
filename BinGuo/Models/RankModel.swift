//
//  RankModel.swift
//  BinGuo
//
//  Created by wzy on 2019/9/23.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation

struct RankModel: Codable {
    var Boylist:[ListModel] = []
    var Charmlist:[ListModel] = []
    var Girllist:[ListModel] = []
    var Lastmodified: String?
    var Moneylist:[ListModel] = []
    var Talentlist:[ListModel] = []
}

struct ListModel: Codable {
    var Age: String?
    var Icon: String?
    var Isauth: String?
    var Isvip: String?
    var Level: String?
    var Nickname: String?
    var Sex: String?
    var Sortid: String?
    var Userid: String?
}
