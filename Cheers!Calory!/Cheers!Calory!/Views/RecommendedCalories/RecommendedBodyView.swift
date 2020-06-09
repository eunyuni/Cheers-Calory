//
//  RecommendedBodyView.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/06/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecommendedBodyView: UIView {

  // MARK: -Property
  private let puppleLine1 = UIView()
  private let puppleLine2 = UIView()
  private let averageWeight = UILabel()
  private let averageWeightLabel = UILabel()
  private let recommendedCalories = UILabel()
  private let recommendedCaloriesLabel = UILabel()

  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
   
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Action
  
  func configue(nickname: String, weight: String, calories: String) {
    averageWeight.text = "\(nickname)의 평균체중"
    averageWeightLabel.text = "  \(weight)  "
    recommendedCalories.text = "\(nickname)의 일일권장칼로리"
    recommendedCaloriesLabel.text = " \(calories) "
  }
  
  // MARK: -setupUI
  
  private func setupUI() {
    self.addSubviews([
    puppleLine1,
    puppleLine2,
    averageWeight,
    averageWeightLabel,
    recommendedCalories,
    recommendedCaloriesLabel
    ])
    
    [puppleLine1, puppleLine2,].forEach {
      $0.backgroundColor = ColorZip.purple
    }
    [averageWeight, recommendedCalories].forEach {
      $0.font = .systemFont(ofSize: 24, weight: .regular)
      $0.textColor = ColorZip.purple
    }
    [averageWeightLabel, recommendedCaloriesLabel].forEach {
      $0.font = .systemFont(ofSize: 24, weight: .regular)
      $0.textColor = ColorZip.purple
      $0.layer.borderWidth = 0.8
      $0.layer.borderColor = ColorZip.purple.cgColor
    }
    
    averageWeight.text = "길동의 평균체중"
    averageWeightLabel.text = "  48kg  "
    recommendedCalories.text = "길동의 일일권장칼로리"
    recommendedCaloriesLabel.text = " 700kcal "
    setupConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setupConstraint() {
    
    puppleLine1.snp.makeConstraints {
      $0.top.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: 100))
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 2))
      $0.width.equalToSuperview().multipliedBy(0.86)
      $0.trailing.equalToSuperview()
    }
    
    puppleLine2.snp.makeConstraints {
      $0.top.equalTo(puppleLine1.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 100))
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 2))
      $0.width.equalToSuperview().multipliedBy(0.9)
      $0.trailing.equalToSuperview()
    }
    
    averageWeight.snp.makeConstraints {
      $0.bottom.equalTo(puppleLine1.snp.top).offset(CGFloat.dynamicYMargin(margin: -10))
      $0.leading.equalTo(puppleLine1.snp.leading)
    }

    averageWeightLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -14))
      $0.top.equalTo(averageWeight)
    }
    
    recommendedCalories.snp.makeConstraints {
      $0.bottom.equalTo(puppleLine2.snp.top).offset(CGFloat.dynamicYMargin(margin: -10))
      $0.leading.equalTo(puppleLine2.snp.leading)
    }
    
    recommendedCaloriesLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -14))
      $0.top.equalTo(recommendedCalories)
    }
    
  }
  

}
