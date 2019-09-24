//
//  HomeModel.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit

struct HomeModel: Codable {
//    var Likeuser:[LikeuserModel]?
//    var Menu:[MenuModel] = []
//    var Recommend:[RecommendModel] = []
    var Topic:[TopicModel] = []
    var Video:[VideoModel] = []
    var Viewurl:ViewurlModel?
    
//    enum CokingKeys: String, CodingKey {
//        case Likeuser
//        case Menu
//        case Recommend
//        case Topic
//        case Video
//        case Viewurl
//    }
}

struct LikeuserModel: Codable {
    var Age: Int?
    var Dispaly: String?
    var Isauth: Int?
    var Nickname: String?
    var Sex: String?
    var Userid: Int?
    
//    enum CokingKeys: String, CodingKey {
//        case Age
//        case Dispaly
//        case Isauth
//        case Nickname
//        case Sex
//        case Userid
//    }
    
}

struct MenuModel: Codable {
    var Icon: String?
    var Target: String?
    var Title: String?
    
//    enum CokingKeys: String, CodingKey {
//        case Icon
//        case Target
//        case Title
//    }
}

struct RecommendModel: Codable {
    var Dispaly: String?
    var Isvip: Int?
    var Nickname: String?
    var Userid: Int?
    
//    enum CokingKeys: String, CodingKey {
//        case Dispaly
//        case Isvip
//        case Nickname
//        case Userid
//    }
}

struct TopicModel: Codable {
    var Desc: String?
    var Dispaly: String?
    var Icon: String?
    var Id: String?
    var Join: String?
    var Title: String?
    
//    enum CokingKeys: String, CodingKey {
//        case Desc
//        case Dispaly
//        case Icon
//        case Id
//        case Join
//        case Title
//    }
}

struct VideoModel: Codable {
    var Gifts: String?
    var Id: String?
    var Like: String?
    var Rates: String?
    var Reviews: String?
    var Title: String?
    var Userinfo: VideoUserInfo?
    var Videoinfo: VideoInfoModel?
    
//    enum CokingKeys: String, CodingKey {
//        case Gifts
//        case Id
//        case Like
//        case Rates
//        case Reviews
//        case Title
//        case Userinfo
//        case Videoinfo
//    }
}

struct VideoUserInfo: Codable {
    var age: String?
    var icon: String?
    var nickname: String?
    var sex: String?
    var userid: String?
    
//    enum CokingKeys: String, CodingKey {
//        case age
//        case icon
//        case nickname
//        case sex
//        case userid
//    }

}
struct VideoInfoModel: Codable {
    var original: String?
    var thumbnail: String?
    
//    enum CokingKeys: String, CodingKey {
//        case original
//        case thumbnail
//    }
}

struct ViewurlModel: Codable {
    var height: UInt?
    var status: String?
    var title: String?
    var url: String?
    
//    enum CokingKeys: String, CodingKey {
//        case height
//        case status
//        case title
//        case url
//    }
}
