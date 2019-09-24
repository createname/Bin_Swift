//
//  CellViewModelProtocol.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import UIKit
import CryptoSwift

protocol CellViewModelProtocol {
    func cellReuseIdentifier() -> String
    func cellSize() -> CGSize
    func cellHeight() -> Float
    func getPicString(picString: String) -> String
}

extension CellViewModelProtocol{
    func cellHeight() -> Float {
        return 0
    }
    
    func cellSize() -> CGSize {
        return CGSize.zero
    }
    
    func getPicString(picString: String) -> String {
        let data = self.data(from: "bc682e3592d76354153eb1e239772b9c0e11c8c55eb1233f2e03d1ab812a227b860ebb3d1a847684db1299577825df1e2f836137f3c16618b425a73aef70a636")
        let aes = try? AES(key: "5093c9ab8e9f1eda42d85dea4b0056d6", iv: "5093c9ab8e9f1eda")
        let dec = (try? aes?.decrypt(data.bytes)) ?? []
        
        let decStr = String(bytes: dec, encoding: .utf8)
        
        //        print("decStr======:\(decStr ?? "")")
        let array = decStr?.components(separatedBy: "$")
        
        let key = array?.first
        
        let iv = array?.last?.replacingOccurrences(of: "\0", with: "")
        
        let endAes = try? AES(key: key!, iv: iv!)
        let picData = self.data(from: picString)
        let endDec = (try? endAes?.decrypt(picData.bytes)) ?? []
        let endUrl = String(bytes: endDec, encoding: .utf8)
        
        let url = endUrl!.replacingOccurrences(of: "\0", with: "")
        //        print("endUrl=======\(endUrl!)")
        return url
    }
    
    ///将十六进制字符串转化为 Data
    func data(from hexStr: String) -> Data {
        let bytes = self.bytes(from: hexStr)
        return Data(bytes: bytes)
    }
    // 将16进制字符串转化为 [UInt8]
    // 使用的时候直接初始化出 Data
    // Data(bytes: Array<UInt8>)
    func bytes(from hexStr: String) -> [UInt8] {
        assert(hexStr.count % 2 == 0, "输入字符串格式不对，8位代表一个字符")
        var bytes = [UInt8]()
        var sum = 0
        // 整形的 utf8 编码范围
        let intRange = 48...57
        // 小写 a~f 的 utf8 的编码范围
        let lowercaseRange = 97...102
        // 大写 A~F 的 utf8 的编码范围
        let uppercasedRange = 65...70
        for (index, c) in hexStr.utf8CString.enumerated() {
            var intC = Int(c.byteSwapped)
            if intC == 0 {
                break
            } else if intRange.contains(intC) {
                intC -= 48
            } else if lowercaseRange.contains(intC) {
                intC -= 87
            } else if uppercasedRange.contains(intC) {
                intC -= 55
            } else {
                assertionFailure("输入字符串格式不对，每个字符都需要在0~9，a~f，A~F内")
            }
            sum = sum * 16 + intC
            // 每两个十六进制字母代表8位，即一个字节
            if index % 2 != 0 {
                bytes.append(UInt8(sum))
                sum = 0
            }
        }
        return bytes
    }
}
