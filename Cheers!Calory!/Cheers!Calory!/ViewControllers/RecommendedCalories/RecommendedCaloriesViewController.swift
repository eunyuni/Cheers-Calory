//
//  RecommendedCaloriesViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecommendedCaloriesViewController: UIViewController {
  
  // MARK: -Property
  private let mainView = RecommendedMainView()
  private let bodyView = RecommendedBodyView()
//  private let bottomView = RecommendedBottomView()
//  private let caloryView1 = CaloryView()
  
  // 수정 테스트~~
  
  
  // MARK: -Lift cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    caloryView1.configue(backColor: ColorZip.morning)
    setupUI()
  }
  
  // MARK: -Action
  
  
  // MARK: -setupUI
  private func setupUI() {
    view.addSubviews([mainView, bodyView])
    
    
    
    setupConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setupConstraint() {
    mainView.snp.makeConstraints {
      $0.top.trailing.leading.equalToSuperview()
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 230))
    }
    bodyView.snp.makeConstraints {
      $0.top.equalTo(mainView.snp.bottom)
      $0.trailing.leading.equalToSuperview()
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 230))
    }
//    bottomView.snp.makeConstraints {
//      $0.top.equalTo(bottomView.snp.bottom)
//      $0.trailing.leading.bottom.equalToSuperview()
//    }
//    caloryView1.snp.makeConstraints {
//      $0.top.equalTo(bodyView.snp.bottom).offset(20)
//      $0.leading.equalToSuperview().offset(20)
//    }
  }
  
}
