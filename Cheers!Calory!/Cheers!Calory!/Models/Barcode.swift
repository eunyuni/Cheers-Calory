//
//  Barcode.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct Barcode: Decodable {
    let barcode: String
    let productName: String
    let base: String
    let origin: String
    
    private enum CodingKeys: String, CodingKey {
        case barcode = "바코드"
        case productName = "상품명"
        case base = "상품분류"
        case origin = "업체명"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        barcode = try container.decode(String.self, forKey: .barcode)
        productName = try container.decode(String.self, forKey: .productName)
        base = try container.decode(String.self, forKey: .base)
        origin = try container.decode(String.self, forKey: .origin)
    }
}
