//
//  ReportViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import Charts

class ReportViewController: UIViewController {
    
    private let headerView = ReportHeaderView()
    private let tableView = UITableView()

    private var chartDatas = [Double]()
    private var xAxis = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateGraph()
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

extension ReportViewController {
    private func setChartData() {
        var cnt = 0
        for i in DailyIntakeDB.shared.keyList {
            cnt += 1
            chartDatas.append(Double(DailyIntakeDB.shared.getDailyIntake(key: i)?.totalCalory ?? 0))
            xAxis.append(getWeakDay(date: DailyIntakeDB.shared.getDailyIntake(key: i)?.today ?? ""))
            if cnt < 7 {
                continue
            } else {
                break
            }
        }
    }
    
    func updateGraph() {
        chartDatas = []
        xAxis = []
        setChartData()
        var lineChartEntry = [ChartDataEntry]()

        for i in 0..<chartDatas.count {
            let value = ChartDataEntry(x: Double(i), y: chartDatas[i])
            lineChartEntry.append(value)
        }
        headerView.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxis)

        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Calories")
        line1.colors = [ColorZip.purple]
        line1.circleRadius = 3
        line1.lineWidth = 2

        let data = LineChartData()
        data.addDataSet(line1)

        headerView.chartView.data = data
        headerView.chartView.notifyDataSetChanged()
        
    }
    
    func getWeakDay(date: String) -> String {
        let weakDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        var returnStr = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date1 = formatter.date(from: date) {
            let cal = Calendar(identifier: .gregorian)
            let index = cal.dateComponents([.weekday], from: date1)
            returnStr = weakDays[index.weekday! - 1]
        } else {
            returnStr = "날짜데이터가 없습니다."
        }
        
        return returnStr
    }
}
