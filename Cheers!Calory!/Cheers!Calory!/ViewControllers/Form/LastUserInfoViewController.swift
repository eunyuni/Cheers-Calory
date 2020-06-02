//
//  LastUserInfoViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class LastUserInfoViewController: UIViewController {
    
    var selectedItem = 0
    var nickName = ""
    var gender = ""
    var age = 0
    var height = 0.0
    var weight = 0.0
    var today = ""
    
    private let heightLabel = UILabel()
    private let heightTextField = UITextField()
    private let weightLabel = UILabel()
    private let weightTextField = UITextField()
    private let infoLabel = UILabel()
    private let completeButton = UIButton()
    
    private let userDefault = UserDefaults.standard
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gender, age, selectedItem, nickName, today)
        heightTextField.delegate = self
        weightTextField.delegate = self
        self.navigationItem.title = "사용자 정보"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .white
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func setUI() {
        [heightLabel, heightTextField, weightLabel, weightTextField, infoLabel, completeButton].forEach {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalTo(view.snp.centerX)
            }
        }
        
        heightLabel.text = "제 키는"
        weightLabel.text = "체중은요"
        
        [heightLabel, weightLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            $0.textAlignment = .center
            
            $0.snp.makeConstraints {
                $0.width.equalTo(CGFloat.dynamicXMargin(margin: 200))
                $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
            }
        }
        
        [heightTextField, weightTextField].forEach {
            $0.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
            $0.textAlignment = .center
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = ColorZip.lightGray.cgColor
            $0.keyboardType = .numberPad
            
            $0.snp.makeConstraints {
                $0.width.equalTo(view.snp.width).multipliedBy(0.8)
                $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
            }
        }
        
        infoLabel.text = "입력하신 정보를 바탕으로 일일권장섭취량이 계산됩니다."
        infoLabel.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        infoLabel.textAlignment = .center
        
        completeButton.layer.masksToBounds = true
        completeButton.layer.cornerRadius = 8
        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = UIColor.lightGray.cgColor
        completeButton.setImage(UIImage(named: "check"), for: .normal)
        completeButton.setBackgroundColor(#colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1), for: .normal)
        completeButton.setBackgroundColor(.lightGray, for: .disabled)
        completeButton.addTarget(self, action: #selector(completeBtn(_:)), for: .touchUpInside)
        completeButton.isEnabled = false
        
        setConstraints()
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        heightLabel.snp.makeConstraints {
            $0.top.equalTo(guide.snp.top).offset(CGFloat.dynamicYMargin(margin: 50))
        }
        
        heightTextField.snp.makeConstraints {
            $0.top.equalTo(heightLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 10))
        }
        
        weightLabel.snp.makeConstraints {
            $0.top.equalTo(heightTextField.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 50))
        }
        
        weightTextField.snp.makeConstraints {
            $0.top.equalTo(weightLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 10))
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(weightTextField.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 5))
//            $0.width.equalTo(view.snp.width).multipliedBy(0.8)
        }
        
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(guide.snp.bottom)
            $0.width.equalTo(view.snp.width).multipliedBy(0.8)
            $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
        }
    }
    
    // 애초에 다 입력 되면 활성화하자!
    @objc private func completeBtn(_ sender: UIButton) {
        print("완료")
        
        var userInfo = UserInfo.shared
        userInfo.selectedItem = self.selectedItem
        userInfo.nickName = self.nickName
        userInfo.gender = self.gender
        userInfo.age = self.age
        userInfo.height = self.height
        userInfo.weight = self.weight
        userInfo.today = self.today
        
        // userDefault에 저장
        userDefault.set(try? JSONEncoder().encode(userInfo), forKey: "userInfo")
        setRootView(window: appDelegate.window!)
    }
}

extension LastUserInfoViewController: UITextFieldDelegate {
    
    // 입력한 값 전역변수에 넘겨주고, (나중에 전역변수를 통해 UserDefault로 저장할 거임) 모든 텍스트필드를 다 입력해야
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let height = heightTextField.text, let weight = weightTextField.text else { return }
        if textField == weightTextField {
            self.weight = Double(Int(weight) ?? 0)
            view.endEditing(true)
        } else {
            self.height = Double(Int(height) ?? 0)
            view.endEditing(true)
        }
        
        if !height.isEmpty && !weight.isEmpty {
            completeButton.isEnabled = true
        } else {
            completeButton.isEnabled = false
        }
    }
    
    // 글자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 3
    }
}



