//
//  ReportViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    private let headerView = ReportHeaderView()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setUI() {
        [headerView, tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.dataSource = self
        tableView.register(ReportsTableViewCell.self, forCellReuseIdentifier: ReportsTableViewCell.identifier)
        setConstraint()
    }
    private func setConstraint() {
       let guide = view.safeAreaLayoutGuide
       
       headerView.snp.makeConstraints {
           $0.top.leading.trailing.equalTo(guide)
        $0.height.equalToSuperview().multipliedBy(0.4)
       }
       
       tableView.snp.makeConstraints {
           $0.top.equalTo(headerView.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 15))
           $0.leading.trailing.bottom.equalTo(guide)
       }
    }
}

extension ReportViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DailyIntakeDB.shared.keyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportsTableViewCell.identifier, for: indexPath) as! ReportsTableViewCell
        let dailyIntake = DailyIntakeDB.shared.getDailyIntake(index: indexPath.row)
        cell.dateLabel.text = dailyIntake?.today
        let totalStr = "\(dailyIntake?.totalCalory ?? 0) kcal"
        cell.caloryLabel.text = totalStr
        return cell
    }
    
    
}
