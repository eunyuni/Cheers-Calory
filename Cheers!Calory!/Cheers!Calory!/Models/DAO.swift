//
//  DAO.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation
import Firebase

class DAO {
    private let userDefaults = UserDefaults.standard
    
    
    // 음식 데이터를 전부 유저디폴트에 저장하고, 있으면 불러와서 검색 테이블뷰의 data로 쓰고, 없으면 호출안함
    private var ref: DatabaseReference!
    private let encoder = JSONEncoder()
    
    
    // 앱 처음 켰을 때 (UserDefault 없을 때) tableView Reload 수정해야함 처음 키면 데이터가 없고, 두 번째 켜야 그때부터 유저디폴트 가지고 뿌려줌
    // 앱 끌때 breakPoint 어쩌구함 이거 뭐임?;;
    
    func search() {
        guard userDefaults.object(forKey: "foodDatas") == nil else { return }
        self.ref = Database.database().reference()
        var data: [Food] = []
        
        // 이 부분 수정
        // 현 상태 (없다고 저장만 하고 끝남)
        // 수정 (없으면 저장한 후 뿌리고, 있으면 저장도 안하고 메소드 종료)
        ref.child("foods").queryOrderedByKey().queryStarting(atValue: "가래떡").observe(.childAdded, with: {(DataSnapshot) in
            guard let value = DataSnapshot.value as? NSDictionary else { return print("검색 결과를 찾을 수 없습니다.") }
            
            // 이 스코프에서 UserDefault에 저장
            let foodName = DataSnapshot.key
            let calory = value["칼로리(kcal)"] as! String
            let service = value["1회제공량(g)"] as! String
            let fat = value["지방(g)"] as! String
            let carbohydrate = value["탄수화물(g)"] as! String
            let protein = value["단백질(g)"] as! String
            
            data.append(Food(foodName: foodName, servingSize: service, calory: calory, carbohydrate: carbohydrate, fat: fat, protein: protein))
            self.userDefaults.set(try? self.encoder.encode(data), forKey: "foodDatas")})
        { (error) in
            print(error.localizedDescription)
        }
        
        let searchVC = SearchViewController()
        searchVC.tableView.reloadData()
    }
}

