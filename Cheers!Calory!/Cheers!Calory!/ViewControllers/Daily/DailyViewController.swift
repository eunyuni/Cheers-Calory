
//
//  DailyViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {
    let headerView = DailyHeaderView() 
    var totalCalory: Int = 0 {
        didSet {
            headerView.label.text = String(totalCalory) + " kcal"
        }
    }
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        return tableView
    }()
    
    private var today = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Daily"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = CGFloat.dynamicYMargin(margin: 60)
        setUI()
        setDatasource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.reloadData()
        // 여기서 데이터 저장
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = CGFloat.dynamicYMargin(margin: 60)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Daily"
    }
    
    private func setUI() {
        view.backgroundColor = .white
        [headerView, tableView].forEach {
            view.addSubview($0)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(guide)
            $0.height.equalTo(CGFloat.dynamicYMargin(margin: 120))
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 15))
            $0.leading.trailing.bottom.equalTo(guide)
        }
    }
    
    private func setDatasource() {
        if let x = UserDefaults.standard.object(forKey: "breakfast") as? Data {
            if let loaded = try? JSONDecoder().decode([Food].self, from: x) {
                dump(loaded)
                DailyIntake.shared.breakfast = loaded
            }
        }
        
        if let x = UserDefaults.standard.object(forKey: "lunch") as? Data {
            if let loaded = try? JSONDecoder().decode([Food].self, from: x) {
                dump(loaded)
                DailyIntake.shared.lunch = loaded
            }
        }
        
        if let x = UserDefaults.standard.object(forKey: "dinner") as? Data {
            if let loaded = try? JSONDecoder().decode([Food].self, from: x) {
                dump(loaded)
                DailyIntake.shared.dinner = loaded
            }
        }
        
        if let x = UserDefaults.standard.object(forKey: "snack") as? Data {
            if let loaded = try? JSONDecoder().decode([Food].self, from: x) {
                dump(loaded)
                DailyIntake.shared.snack = loaded
            }
        }
        self.tableView.reloadData()
    }
}

extension DailyViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return DailyIntake.shared.breakfast.count
        case 1:
            return DailyIntake.shared.lunch.count
        case 2:
            return DailyIntake.shared.dinner.count
        case 3:
            return DailyIntake.shared.snack.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
        
        var name = ""
        var base = ""
        var calory = ""
        
        switch indexPath.section {
        case 0:
            name = DailyIntake.shared.breakfast[indexPath.row].foodName
            base = DailyIntake.shared.breakfast[indexPath.row].servingSize
            calory = DailyIntake.shared.breakfast[indexPath.row].calory
        case 1:
            name = DailyIntake.shared.lunch[indexPath.row].foodName
            base = DailyIntake.shared.lunch[indexPath.row].servingSize
            calory = DailyIntake.shared.lunch[indexPath.row].calory
        case 2:
            name = DailyIntake.shared.dinner[indexPath.row].foodName
            base = DailyIntake.shared.dinner[indexPath.row].servingSize
            calory = DailyIntake.shared.dinner[indexPath.row].calory
        case 3:
            name = DailyIntake.shared.snack[indexPath.row].foodName
            base = DailyIntake.shared.snack[indexPath.row].servingSize
            calory = DailyIntake.shared.snack[indexPath.row].calory
        default:
            break
        }
        cell.foodName.text = name
        cell.foodBase.text = "\(base)(g)"
        
        if base.contains("가공") {
            cell.foodKcal.text = "\(calory)"
        } else {
            cell.foodKcal.text = "\(calory) kcal"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DailySectionHeaderView()
        view.section = section
        view.backgroundColor = ColorZip.purple
        view.delegate = self
        
        switch section {
        case 0:
            view.foodLabel.text = "아침" as String
        case 1:
            view.foodLabel.text = "점심" as String
        case 2:
            view.foodLabel.text = "저녁" as String
        case 3:
            view.foodLabel.text = "간식" as String
        default:
            break
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var todayCalory = UserDefaults.standard.integer(forKey: Date.dateFormatting(yyyyMMDD: "yyyyMMdd"))
        
        
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
//                todayCalory -= Int(DailyIntake.shared.breakfast[indexPath.row].calory)
                let intCalory = DailyIntake.shared.breakfast[indexPath.row].calory.trimmingCharacters(in: [" "])
                DailyIntake.shared.totalCalory -= Int(intCalory) ?? 0
                DailyIntake.shared.breakfast.remove(at: indexPath.row)
            case 1:
                let intCalory = DailyIntake.shared.lunch[indexPath.row].calory.trimmingCharacters(in: [" "])
                DailyIntake.shared.totalCalory -= Int(intCalory) ?? 0
                DailyIntake.shared.lunch.remove(at: indexPath.row)
            case 2:
                let intCalory = DailyIntake.shared.dinner[indexPath.row].calory.trimmingCharacters(in: [" "])
                DailyIntake.shared.totalCalory -= Int(intCalory) ?? 0
                DailyIntake.shared.dinner.remove(at: indexPath.row)
            case 3:
                let intCalory = DailyIntake.shared.snack[indexPath.row].calory.trimmingCharacters(in: [" "])
                DailyIntake.shared.totalCalory -= Int(intCalory) ?? 0
                DailyIntake.shared.snack.remove(at: indexPath.row)
            default:
                break
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        UserDefaults.standard.set(todayCalory, forKey: Date.dateFormatting(yyyyMMDD: "yyyyMMdd"))
        self.totalCalory = DailyIntake.shared.totalCalory
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var base = ""
        
        switch indexPath.section {
        case 0:
            base = DailyIntake.shared.breakfast[indexPath.row].servingSize
        case 1:
            base = DailyIntake.shared.lunch[indexPath.row].servingSize
        case 2:
            base = DailyIntake.shared.dinner[indexPath.row].servingSize
        case 3:
            base = DailyIntake.shared.snack[indexPath.row].servingSize
        default:
            break
        }
        
        let foodDetailVC = FoodDetailViewController()
        navigationController?.pushViewController(foodDetailVC, animated: true)
        
        // 가공식품이면 어쩌구, 아니면 저쩌구
        if base.contains("가공") {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.dynamicYMargin(margin: 50)
    }
    
    // 이건 어디에 쓰는 거지
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let indexPathValue = indexPath
        return indexPathValue
    }
    
}

extension DailyViewController: DailySectionHeaderViewDelegate {
    func didTapPlusButton(section: Int) {
        let searchVC = SearchViewController()
        searchVC.section = section
        
        let navi = UINavigationController(rootViewController: searchVC)
        present(navi, animated: true, completion: nil)
    }
    
    
}
