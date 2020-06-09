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
  func configue(backColor: UIColor) {
    squareView.backgroundColor = backColor
    circleView.backgroundColor = backColor
    
  }
  
  // MARK: -setupUI
  
  private func setupUI() {
    self.addSubviews([squareView, circleView, titleLabel, caloryLabel])
    
    squareView.layer.cornerRadius = 4
    circleView.layer.cornerRadius = circleView.frame.height/2
    circleView.layer.borderWidth = 6
    circleView.layer.borderColor = UIColor.white.cgColor
    circleView.clipsToBounds = true
    
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
      $0.width.equalTo(CGFloat.dynamicXMargin(margin: 144))
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 94))
      $0.leading.trailing.bottom.equalToSuperview()
      $0.top.equalToSuperview().offset(CGFloat.dynamicYMargin(margin: 60))
    }
    circleView.snp.makeConstraints {
      $0.width.height.equalTo(88)
      $0.centerX.equalTo(squareView.snp.top)
    }
  }
  

}
