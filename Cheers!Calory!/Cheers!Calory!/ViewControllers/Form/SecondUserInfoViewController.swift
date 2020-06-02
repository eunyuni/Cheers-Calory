//
//  SecondUserInfoViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class SecondUserInfoViewController: UIViewController, UITextFieldDelegate {
    
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let genderLabel = UILabel()
    private let genderSegment = UISegmentedControl(items: ["남자", "여자"])
    private let birthLabel = UILabel()
    private let birthTextField = UITextField()
    private let infoLabel = UILabel()
    private let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nameTextField.delegate = self
        birthTextField.delegate = self
        self.navigationItem.title = "사용자 정보"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setUI()
        self.birthTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    private func setUI() {
        [nameLabel, nameTextField, genderLabel, genderSegment, birthLabel, birthTextField, nextButton].forEach {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalTo(view.snp.centerX)
                $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
            }
        }
        
        [nameLabel, genderLabel, birthLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            $0.textAlignment = .center
            
            $0.snp.makeConstraints {
                $0.width.equalTo(CGFloat.dynamicXMargin(margin: 200))
            }
        }
        
        [nameTextField, birthTextField].forEach {
            $0.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
            $0.textAlignment = .center
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = ColorZip.lightGray.cgColor
            
            $0.snp.makeConstraints {
                $0.width.equalTo(view.snp.width).multipliedBy(0.8)
            }
            
        }
        
        nameLabel.text = "제 이름은요"
        
        genderLabel.text = "저는요"
        
        view.addSubview(infoLabel)
        infoLabel.text = "사용자 정보는 서버에 저장되지 않으니, 안심하셔도 됩니다."
        infoLabel.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        infoLabel.textAlignment = .center
        
        genderSegment.selectedSegmentIndex = 1
        genderSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .ultraLight)], for: .normal)
        genderSegment.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .selected)
        genderSegment.layer.borderWidth = 1
        genderSegment.layer.borderColor = ColorZip.lightGray.cgColor
        genderSegment.selectedSegmentTintColor =  #colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1) // 126, 57, 251
        genderSegment.addTarget(self, action: #selector(switchGender(_:)), for: .valueChanged)
        
        birthLabel.text = "생년월일은"
        
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 8
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.lightGray.cgColor
        nextButton.setImage(UIImage(named: "check"), for: .normal)
        nextButton.setBackgroundColor(#colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1), for: .normal)
        nextButton.setBackgroundColor(.lightGray, for: .disabled)
        nextButton.addTarget(self, action: #selector(goNext(_:)), for: .touchUpInside)
        nextButton.isEnabled = false
        
        setConstraints()
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(guide.snp.top).offset(CGFloat.dynamicYMargin(margin: 50))
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 10))
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 50))
        }
        
        genderSegment.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 10))
            $0.width.equalTo(guide.snp.width).multipliedBy(0.8)
        }
        
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(genderSegment.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 50))
        }
        
        birthTextField.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 10))
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(birthTextField.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 5))
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(guide.snp.bottom)
            $0.width.equalTo(guide.snp.width).multipliedBy(0.8)
        }
    }
    
    @objc private func switchGender(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("남자"); break
        case 1:
            print("여자"); break
        default:
            break
        }
    }
    
    // 다 입력해야만 활성화
    @objc private func goNext(_ sender: UIButton) {
        let lastVC = LastUserInfoViewController()
        navigationController?.pushViewController(lastVC, animated: true)
        
        // 생년월일 텍스트필드 값 Date 타입으로 변환
        let dateStr = birthTextField.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        // 오늘 - 생일 = 만 나이 구하기
        let birthDay = dateFormatter.date(from: dateStr)
        let today = Date()
        let different = today.timeIntervalSince(birthDay!)
        let age = Int(different / (86400 * 365))
        
        // 세그먼트에 선택 된 타이틀 값 저장
        let gender = genderSegment.titleForSegment(at: genderSegment.selectedSegmentIndex)!
        
        // 빈칸이면 return 빈칸 아니면 넘겨줌
        guard let text = nameTextField.text else { return print("이름 안들어감")}
        
        let todayStr = Date.dateFormatting(yyyyMMDD: "yyyy년 MM월 dd일")
        
        // 여기서 세그먼트 값(성별)이랑, 생년월일 전역변수에 저장
        lastVC.today = todayStr
        lastVC.nickName = text
        lastVC.gender = gender
        lastVC.age = age
    }
    
    // 생년월일 확인 버튼
    @objc private func tapDone() {
        
        if let datePicker = self.birthTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY년 M월 d일"
            self.birthTextField.text = dateformatter.string(from: datePicker.date)
        }
        // datePicker에서 선택한 날짜 String type으로 textfield에 뿌림
        self.birthTextField.resignFirstResponder() // 2-5
    }
    
    // 다음 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let birthText = birthTextField.text, let nameText = nameTextField.text else { return }
        
        if !birthText.isEmpty && !nameText.isEmpty{
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

