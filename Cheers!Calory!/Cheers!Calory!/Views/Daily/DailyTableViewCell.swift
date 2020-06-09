//
//  DailyTableViewCell.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/03.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    static let identifier = "dailyCell"
    
    let foodName = UILabel()
    let foodBase = UILabel()
    let foodKcal = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [foodName, foodBase, foodKcal].forEach {
            self.addSubview($0)
        }
        
        foodName.font = .systemFont(ofSize: 16, weight: .ultraLight)
        foodBase.font = .systemFont(ofSize: 12, weight: .ultraLight)
        foodKcal.font = .systemFont(ofSize: 16, weight: .medium)
        foodBase.textColor = .gray
        foodName.textColor = .black
        foodKcal.textColor = .black
        
        setConstraints()
    }
    
    private func setConstraints() {
        foodName.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(CGFloat.dynamicXMargin(margin: 20))
            $0.centerY.equalTo(self.snp.centerY).offset(CGFloat.dynamicYMargin(margin: -10))
        }
        
        foodBase.snp.makeConstraints {
            $0.top.equalTo(foodName.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 5))
            $0.leading.equalTo(self.snp.leading).offset(CGFloat.dynamicXMargin(margin: 20))
        }
        
        foodKcal.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(CGFloat.dynamicXMargin(margin: -24))
            $0.centerY.equalTo(self.snp.centerY)
        }
    }
}
