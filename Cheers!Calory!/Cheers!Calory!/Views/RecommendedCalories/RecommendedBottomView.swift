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
  private let lunchView = CaloryView()
  private let eveningView = CaloryView()
  private let snackView = CaloryView()
  private let commentLable = UILabel()
  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Action
  
  func configue(morning: String, lunch: String, evening: String, snack: String) {
    morningView.configue(backColor: ColorZip.morning, title: "아침", calory: morning)
    lunchView.configue(backColor: ColorZip.lunch, title: "점심", calory: lunch)
    eveningView.configue(backColor: ColorZip.evening, title: "저녁", calory: evening)
    snackView.configue(backColor: ColorZip.snack, title: "간식", calory: snack)
  }
  
  // MARK: -setupUI
  
  private func setupUI() {
    
    morningView.configue(backColor: ColorZip.morning, title: "아침", calory: "180")
    lunchView.configue(backColor: ColorZip.lunch, title: "점심", calory: "180")
    eveningView.configue(backColor: ColorZip.evening, title: "저녁", calory: "180")
    snackView.configue(backColor: ColorZip.snack, title: "간식", calory: "180")
    
    commentLable.text = "아침:점심:저녁:간식 = 3:4:2:1"
    commentLable.font = .systemFont(ofSize: 12, weight: .ultraLight)
    commentLable.textColor = ColorZip.midiumGray
    
    self.addSubviews([
    morningView,
    lunchView,
    eveningView,
    snackView,
    commentLable,
    ])
    setupConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setupConstraint() {
    
    morningView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: 32))
      $0.top.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: 14))
    }
    
    lunchView.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -32))
      $0.top.equalTo(morningView.snp.top)
    }
    
    eveningView.snp.makeConstraints {
      $0.leading.equalTo(morningView.snp.leading)
      $0.top.equalTo(morningView.snp.bottom).offset(CGFloat.dynamicXMargin(margin: 16))
    }
    
    snackView.snp.makeConstraints {
      $0.trailing.equalTo(lunchView.snp.trailing)
      $0.top.equalTo(eveningView.snp.top)
    }
    
    commentLable.snp.makeConstraints {
      $0.top.equalTo(eveningView.snp.bottom).offset(CGFloat.dynamicXMargin(margin: 4))
      $0.leading.equalTo(eveningView.snp.leading)
    }
  }
  

}
