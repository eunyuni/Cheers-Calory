//
//  DailyCaloricIntake.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/11.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct DailyCaloricIntake: Encodable {
    
    let today = Date.dateFormatting(yyyyMMDD: "yyyyMMdd")
    
    var breakfast = [Food]()
    var lunch = [Food]()
    var dinner = [Food]()
    var snack = [Food]()
    
    var totalCalory: Int = 0
    
}
