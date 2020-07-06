//
//  ReportDetailViewController.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/07/01.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class ReportDetailViewController: UIViewController {
  
  
  // MARK: -Property
  var breakfast = [Food]()
  var lunch = [Food]()
  var dinner = [Food]()
  var snack = [Food]()
  
  private let dateView = UIView()
  private let dateLabel = UILabel()
  private let breakfastView = ReportsDetailView(food: nil)
  private let lunchView = ReportsDetailView(food: nil)
  
//  private let tableView = UITableView()
  
  // 얘한테 특정 날짜에 대한 식단정보가 들어있음
  // dateLabel 텍스트 설정하는 부분(60번째 줄), 아침, 점심 총 칼로리 텍스트 설정하는 부분 (106, 110번째 줄) 참고 할 것
  var dailyDetail: DailyCaloricIntake
  
  // ReportViewController 74번째 줄에서 쓰임
  init(dailyDetail: DailyCaloricIntake) {
    self.dailyDetail = dailyDetail
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Lift cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUI()
  }
  
  // MARK: -Action
  
  
  // MARK: -setupUI
  private func setUI() {
    view.addSubviews([
      dateView,
      breakfastView,
      lunchView,
    ])
    
    dateView.addSubview(dateLabel)
    
    dateView.backgroundColor = ColorZip.purple
    dateLabel.textColor = .white
    dateLabel.text = dailyDetail.today
    dateLabel.textAlignment = .center
    
    breakfastView.configue(title: "아침", totalCalory: "\(dailyDetail.breakfastTotalCalory)")
    lunchView.configue(title: "점심", totalCalory: "\(dailyDetail.lunchTotalCalory)")
//    tableView.dataSource = self
//    tableView.separatorStyle = .none
//    tableView.register(ReprotsDetailTableViewCell.self, forCellReuseIdentifier: ReprotsDetailTableViewCell.identifier)
    
    setConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    
    dateView.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.1)
    }
    dateLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
    
    breakfastView.snp.makeConstraints {
      $0.top.equalTo(dateView.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.2)
    }
    lunchView.snp.makeConstraints {
      $0.top.equalTo(breakfastView.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.2)
    }
//    tableView.snp.makeConstraints {
//      $0.top.equalTo(dateView.snp.bottom)
//      $0.leading.trailing.bottom.equalTo(guide)
//    }
  }
  
}


//extension ReportDetailViewController: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    4
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    switch indexPath.row {
//    case 0:
//      let cell = tableView.dequeueReusableCell(withIdentifier: ReprotsDetailTableViewCell.identifier, for: indexPath) as! ReprotsDetailTableViewCell
//      cell.configue(title: "아침", totalCalory: "\(dailyDetail.breakfastTotalCalory)")
//      return cell
//    case 1:
//      let cell = tableView.dequeueReusableCell(withIdentifier: ReprotsDetailTableViewCell.identifier, for: indexPath) as! ReprotsDetailTableViewCell
//      cell.configue(title: "점심", totalCalory: "\(dailyDetail.lunchTotalCalory)")
//      return cell
//
//    default:
//      return UITableViewCell()
//
//    }
//  }
//}
