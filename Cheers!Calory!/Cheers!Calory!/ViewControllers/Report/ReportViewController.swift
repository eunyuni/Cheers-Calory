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
    
    private func setUI() {
        
        [headerView, tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let dailyIntake = DailyIntakeDB.shared.getDailyIntake(index: indexPath.row)
        cell.textLabel?.text = dailyIntake?.today
        return cell
    }
    
    
}
