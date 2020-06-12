//
//  DailyIntake.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/03.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct DailyIntake {
    static var shared = DailyIntake()
    private init(){}
    
    var breakfast: [Food] = [] { didSet { UserDefaults.standard.set(try? JSONEncoder().encode(breakfast), forKey: "breakfast")}}
    var lunch: [Food] = [] { didSet { UserDefaults.standard.set(try? JSONEncoder().encode(lunch), forKey: "lunch") }}
    var dinner: [Food] = [] { didSet { UserDefaults.standard.set(try? JSONEncoder().encode(dinner), forKey: "dinner") }}
    var snack: [Food] = [] { didSet { UserDefaults.standard.set(try? JSONEncoder().encode(snack), forKey: "snack") }}
    
    var totalCalory: Int = UserDefaults.standard.integer(forKey: Date.dateFormatting(yyyyMMDD: "yyyyMMdd") + "kcal") { didSet {UserDefaults.standard.set(totalCalory, forKey: Date.dateFormatting(yyyyMMDD: "yyyyMMdd") + "kcal")}}
    
//    var dailyTotal = [DailyIntake]()
}
