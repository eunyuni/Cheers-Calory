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
  private let dateView = UIView()
  private let dateLabel = UILabel()
  private let tableView = UITableView()
  
  // MARK: -Lift cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: -Action
  
  
  // MARK: -setupUI
  private func setUI() {
    view.addSubviews([
      dateView,
      tableView,
      
    ])
    
    dateView.addSubview(dateLabel)
    
    dateView.backgroundColor = ColorZip.purple
    dateLabel.textColor = .white
    dateLabel.text = "2020.07.10"
    dateLabel.textAlignment = .center
    
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.register(ReprotsDetailTableViewCell.self, forCellReuseIdentifier: ReprotsDetailTableViewCell.identifier)
    
    setConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    
    dateView.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.12)
    }
    dateLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-20)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(dateView.snp.bottom)
      $0.leading.trailing.bottom.equalTo(guide)
    }
  }
  
}


extension ReportDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: ReprotsDetailTableViewCell.identifier, for: indexPath) as! ReprotsDetailTableViewCell
      //        let dailyIntake = DailyIntakeDB.shared.getDailyIntake(index: indexPath.row)
      //        cell.dateLabel.text = dailyIntake?.today
      //        let totalStr = "\(dailyIntake?.totalCalory ?? 0) kcal"
      //        cell.caloryLabel.text = totalStr
      cell.configue(title: "아침", totalCalory: "340")
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: ReprotsDetailTableViewCell.identifier, for: indexPath) as! ReprotsDetailTableViewCell
      cell.configue(title: "점심", totalCalory: "490")
      return cell
      
    default:
      return UITableViewCell()
      
    }
  }
  
  
}
