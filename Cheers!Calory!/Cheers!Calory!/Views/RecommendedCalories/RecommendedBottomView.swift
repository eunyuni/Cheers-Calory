//
//  RecommendedBottomView.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/06/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecommendedBottomView: UIView {

  // MARK: -Property
  private let morningView = CaloryView()
  
  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: frame)
//    morningView.configue(backColor: ColorZip.morning, title: "아침", calory: "180kcal")
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Action
  
  func configue() {
    
  }
  
  // MARK: -setupUI
  
  private func setupUI() {
    
    self.addSubviews([
    morningView,
    ])
    setupConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setupConstraint() {
    
    morningView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: 30))
      $0.top.equalToSuperview().offset(30)
    }
  }
  

}
