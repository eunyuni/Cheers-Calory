//
//  FoodDetailViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    private let foodTitle = UILabel()
    private let seperator = UIView()
    private let once = UILabel()
    private let protein = UILabel()
    private let fat = UILabel()
    private let carbohydrate = UILabel()
    private let totalCal = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layer.cornerRadius = 10
        
        self.view.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.66)
            $0.height.equalToSuperview().multipliedBy(0.33)
        }
    }
    
    // 델리게이트 패턴으로 레이블 타이틀 전달해줄것
    private func setUI() {
        view.backgroundColor = ColorZip.alert
        
        
    }
}
