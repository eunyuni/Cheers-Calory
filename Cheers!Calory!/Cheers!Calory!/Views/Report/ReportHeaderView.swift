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
    
    // 계산프로퍼티로 만들어서 DailyIntakeDB의 KeyList의 맨 뒤 7개의 totalCalory만 꺼내오자
    private let chartDatas: [Double] = [2346, 2200, 2000, 1897, 1458, 2509, 1203]

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
    }
    
    private func setConstraints() {
        chartView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().multipliedBy(0.95)
        }
    }
    
    private func setChartView() {
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.text = "지난 일주일간 칼로리 추이"
        chartView.xAxis.granularity = 1
        
    }
    
    private func updateGraph() {
        var lineChartEntry = [ChartDataEntry]()

        for i in 0..<chartDatas.count {
            
            let value = ChartDataEntry(x: Double(i), y: chartDatas[i])
            lineChartEntry.append(value)
        }
        let xAxis = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
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
}
