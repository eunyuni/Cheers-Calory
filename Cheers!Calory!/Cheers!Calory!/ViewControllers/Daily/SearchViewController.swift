//
//  SearchViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import Firebase

protocol BarcodeDataDelegate {
    func sendBarcodeData(barcode: String)
}

class SearchViewController: UIViewController {
    var section = 0
    
    private let dao = DAO()
    private var ref: DatabaseReference!
    
    private var delegate: BarcodeDataDelegate?
    
    private let label = UILabel()
    private let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    
//    private var dailyCaloric = DailyCaloricIntake()
    private var data = [Food]()
    private var filteredDatas = [Food]()
    
    private var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setConstraints()
        
        self.ref = Database.database().reference()
        view.backgroundColor = .white
        
        dao.search()
        setFoodDatas()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "음식을 검색하세요"
        
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setConstraints() {
        view.addSubview(tableView)
        let guide = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(guide)
        }
    }
    
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Search"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "barcode"), style: .plain, target: self, action: #selector(tapBarcodeBtn(_:)))
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.searchController = searchController
    }
    
    private func setFoodDatas() {
        if let savedFoodDatas = UserDefaults.standard.object(forKey: "foodDatas") as? Data {
            let decoder = JSONDecoder()
            if let loadedFoods = try? decoder.decode([Food].self, from: savedFoodDatas) {
                self.data = loadedFoods
            }
        }
    }
    
    @objc private func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func tapBarcodeBtn(_ sender: UIBarButtonItem) {
        let camVC = CameraViewController()
        camVC.delegate = self
        present(camVC, animated: true)
    }
}

extension SearchViewController {
    private func selectDailyCalorieIntake() {
        // 비어있으면, today에 넣어줌
        if DailyIntakeDB.shared.dailyCaloricIntakeArray.count == 0 {
            DailyIntakeDB.shared.dailyCaloricIntakeArray.append(DailyCaloricIntake.shared)
        } else {
            // 비어있지 않다면, 마지막꺼가 오늘날짜인지 확인하고, 아니면 어펜드 해주고, 맞으면 수정
            if DailyIntakeDB.shared.dailyCaloricIntakeArray[DailyIntakeDB.shared.dailyCaloricIntakeArray.endIndex - 1].today == Date.dateFormatting(yyyyMMDD: "yyyyMMdd") {
                DailyIntakeDB.shared.dailyCaloricIntakeArray[DailyIntakeDB.shared.dailyCaloricIntakeArray.endIndex - 1] = DailyCaloricIntake.shared
            } else {
                print("저기")
                DailyIntakeDB.shared.dailyCaloricIntakeArray.append(DailyCaloricIntake.shared)
            }
        }
    }
    
    private func filterContentForSearchText(searchText: String) {
        filteredDatas = data.filter { (food: Food) -> Bool in
            return food.foodName.contains(searchText)
        }
        tableView.reloadData()
    }
    
    private func barcodeSearching(barcode: String) {
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("탭바 없음")}
        guard let navi = tabbar.viewControllers?[1] as? UINavigationController else { return print("네비게이션 없음")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("데일리 없음")}
        
        ref.child("product").child(barcode).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            let food = Food(foodName: value?["제품명"] as? String ?? "없음",
                            servingSize: value?["상품분류"] as? String ?? "0",
                            calory: value?["원산지"] as? String ?? "0",
                            carbohydrate: "0", fat: "0", protein: "0")
            
            switch self.section {
            case 0: DailyIntake.shared.breakfast.append(food)
            case 1: DailyIntake.shared.lunch.append(food)
            case 2: DailyIntake.shared.dinner.append(food)
            case 3: DailyIntake.shared.snack.append(food)
            default: print("안됨")
            }
            
            self.selectDailyCalorieIntake()
            
            dailyVC.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

extension SearchViewController: BarcodeDataDelegate {
    func sendBarcodeData(barcode: String) {
        barcodeSearching(barcode: barcode)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredDatas.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let food: Food
        
        if isFiltering {
            food = filteredDatas[indexPath.row]
        } else {
            food = data[indexPath.row]
        }
        cell.textLabel?.text = food.foodName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("탭바 없음")}
        guard let navi = tabbar.viewControllers?[1] as? UINavigationController else { return print("네비게이션 없음")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("데일리 없음")}
        
        let food: Food
        
        if isFiltering {
            food = filteredDatas[indexPath.row]
        } else {
            food = data[indexPath.row]
        }
    
        // 비었는지 안비었는지 확인,
        // 비었다면 하나 넣어줌
        // 안비었다면 마지막 녀석의 날짜가 오늘 날짜와 같은지 확인
        // 오늘 날짜와 같으면 마지막 녀석에 append
        // 오늘 날짜와 같지 않으면 하나 추가해주고, today에 새로 할당
        
        switch self.section {
        case 0: DailyCaloricIntake.shared.breakfast.append(food)
        case 1: DailyCaloricIntake.shared.lunch.append(food)
        case 2: DailyCaloricIntake.shared.dinner.append(food)
        case 3: DailyCaloricIntake.shared.snack.append(food)
        default: break
        }
        
        selectDailyCalorieIntake()
        
        if isFiltering {
            self.presentingViewController?.dismiss(animated: true)
        } else {
            self.dismiss(animated: true)
        }
        
        dailyVC.tableView.reloadData()
        
        // 오늘 먹은 칼로리 합산 기능 같은데, 수정 해야 할 듯
        let convertedCalory = food.calory.trimmingCharacters(in: [" "])
        
        DailyCaloricIntake.shared.totalCalory += Int(convertedCalory) ?? 0
        DailyIntakeDB.shared.dailyCaloricIntakeArray[DailyIntakeDB.shared.dailyCaloricIntakeArray.endIndex - 1].totalCalory = DailyCaloricIntake.shared.totalCalory
        dailyVC.totalCalory = DailyCaloricIntake.shared.totalCalory
        
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
}
