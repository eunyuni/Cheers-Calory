//
//  CaloryView.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/06/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit



class CaloryView: UIView {

  // MARK: -Property
  private let squareView = UIView()
  private let circleView = UIView()
  private let titleLabel = UILabel()
  private let caloryLabel = UILabel()
  
  struct Padding {
    static let squareWidth: CGFloat = 144
    static let squareHeight: CGFloat = 84
    static let circleWidth: CGFloat = 88
  }
  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Action
//  , title: String, calory: String
  func configue(backColor: UIColor, title: String, calory: String) {
    squareView.backgroundColor = backColor
    circleView.backgroundColor = backColor
    titleLabel.text = "\(title)"
    caloryLabel.text = "\(calory)kcal"
  }
  
  // MARK: -setupUI
  
  private func setupUI() {
    self.addSubviews([
      squareView,
      circleView,
      titleLabel,
      caloryLabel
    ])
    
    squareView.layer.cornerRadius = 14
    
    circleView.layer.borderWidth = 6
    circleView.layer.borderColor = UIColor.white.cgColor
    circleView.clipsToBounds = true
    circleView.layer.cornerRadius = 44
    
    titleLabel.font = .systemFont(ofSize: 32, weight: .regular)
    caloryLabel.font = .systemFont(ofSize: 28, weight: .regular)
    
    [titleLabel, caloryLabel].forEach {
      $0.textColor = .white
      $0.textAlignment = .center
    }
    setupConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setupConstraint() {
    
    squareView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(CGFloat.dynamicYMargin(margin: 40))
      $0.width.equalTo(CGFloat.dynamicXMargin(margin: Padding.squareWidth))
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: Padding.squareHeight))
      $0.leading.trailing.bottom.equalToSuperview()
    }
    circleView.snp.makeConstraints {
      $0.width.equalTo(CGFloat.dynamicXMargin(margin: Padding.circleWidth))
      $0.height.equalTo(circleView.snp.width)
      $0.centerY.equalTo(squareView.snp.top)
      $0.centerX.equalTo(squareView.snp.centerX)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerY.equalTo(circleView.snp.centerY)
      $0.centerX.equalTo(circleView.snp.centerX)
    }
    caloryLabel.snp.makeConstraints {
      $0.centerX.equalTo(squareView.snp.centerX)
      $0.bottom.equalTo(squareView.snp.bottom).offset(CGFloat.dynamicXMargin(margin: -2))
    }
  }
}
