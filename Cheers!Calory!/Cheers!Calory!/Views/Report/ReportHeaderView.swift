//
//  ReportHeaderView.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/26.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import Charts

class ReportHeaderView: UIView {
    
    private let chartView = LineChartView()
    
    
    // 레이블도 해야하니깐 해당 날짜의 요일 구하는 함수 만들어서 DailyCaloricIntake에 계산프로퍼티 작성해줘서 거기에서 꺼내서 레이블에 넣어주자 => 안됨
    // 오늘 값 업데이트랑 x축 레이블 설정하는 방법 수정할 것
    private var chartDatas = [Double]()
    private var xAxis = [String]()

    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(chartView)
        setConstraints()
        setChartView()
        updateGraph()
        print("데이터", chartDatas)
        print("날짜", xAxis)
    }
    
    private func setConstraints() {
        chartView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().multipliedBy(0.95)
        }
    }
    
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
    
    private func setChartView() {
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.text = "지난 일주일간 칼로리 추이"
        chartView.xAxis.granularity = 1
        
    }
    
    func updateGraph() {
        setChartData()
        var lineChartEntry = [ChartDataEntry]()

        for i in 0..<chartDatas.count {
            let value = ChartDataEntry(x: Double(i), y: chartDatas[i])
            lineChartEntry.append(value)
        }
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxis)

        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Calories")
        line1.colors = [ColorZip.purple]
        line1.circleRadius = 3
        line1.lineWidth = 2

        let data = LineChartData()
        data.addDataSet(line1)

        chartView.data = data
        chartView.notifyDataSetChanged()
        
    }
    
    func getWeakDay(date: String) -> String {
        let weakDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        var returnStr = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let date1 = formatter.date(from: date)!
        
        let cal = Calendar(identifier: .gregorian)
        let index = cal.dateComponents([.weekday], from: date1)
        
        returnStr = weakDays[index.weekday! - 1]
        return returnStr
    }
}
