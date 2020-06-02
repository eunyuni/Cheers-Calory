//
//  FirstUserInfoViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import SnapKit

class FirstUserInfoViewController: UIViewController {
    
    private let questionLabel = UILabel()
    private let inActivateButton = UIButton()
    private let littleActivateButton = UIButton()
    private let activateButton = UIButton()
    private let veryActivateButton = UIButton()
    
    private var selectedItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "시작하기"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = ColorZip.purple
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
        setConstraints()
    }
    
    private func setUI() {
        view.addSubview(questionLabel)
        
        // 버튼
        [inActivateButton, littleActivateButton, activateButton, veryActivateButton].forEach {
            view.addSubview($0)
            $0.layer.cornerRadius = 15
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.masksToBounds = true
            $0.titleLabel?.numberOfLines = 3
            $0.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
            $0.setTitleColor(.black, for: .normal)
            $0.setBackgroundColor(.clear, for: .normal)
            $0.setBackgroundColor(ColorZip.purple, for: .selected)
            $0.setTitleColor(.white, for: .selected)
            $0.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        }
        inActivateButton.tag = 0
        littleActivateButton.tag = 1
        activateButton.tag = 2
        veryActivateButton.tag = 3
    
        questionLabel.text = "어느정도 활동적인가요?"
        questionLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        questionLabel.textAlignment = .center
        
        inActivateButton.setTitle("""
        매우 활동적이지 않음
        하루중 대부분을 앉아서 보냄
        (ex: 사무직)
        """, for: .normal)
        
        littleActivateButton.setTitle("""
        약간 활동적
        하루 중 상당 시간을 서서 지냄
        (ex: 교사, 판매원)
        """, for: .normal)
        
        activateButton.setTitle("""
        활동적
        하루 중 상당 시간을 신체 활동을
        하면서 보냄 (ex: 서빙 직원)
        """, for: .normal)
        
        veryActivateButton.setTitle("""
        매우 활동적
        하루 중 대부분을 격렬한 신체 활동을
        하면서 보냄(ex: 목수, 택배기사)
        """, for: .normal)
        
        let fontSize = UIFont.boldSystemFont(ofSize: 20)
        
        let attributedInactivateStr = NSMutableAttributedString(string: inActivateButton.titleLabel!.text!)
        attributedInactivateStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (inActivateButton.titleLabel!.text! as NSString).range(of: "매우 활동적이지 않음"))
        inActivateButton.titleLabel!.attributedText = attributedInactivateStr
        
        let attributedlittleActivateStr = NSMutableAttributedString(string: littleActivateButton.titleLabel!.text!)
        attributedlittleActivateStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (littleActivateButton.titleLabel!.text! as NSString).range(of: "약간 활동적"))
        littleActivateButton.titleLabel!.attributedText = attributedlittleActivateStr
        
        let attributedActivateStr = NSMutableAttributedString(string: activateButton.titleLabel!.text!)
        attributedActivateStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (activateButton.titleLabel!.text! as NSString).range(of: "활동적"))
        activateButton.titleLabel!.attributedText = attributedActivateStr
        
        let attributedVeryActivateStr = NSMutableAttributedString(string: veryActivateButton.titleLabel!.text!)
        attributedVeryActivateStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (veryActivateButton.titleLabel!.text! as NSString).range(of: "매우 활동적"))
        veryActivateButton.titleLabel!.attributedText = attributedVeryActivateStr
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        [inActivateButton, littleActivateButton, activateButton, veryActivateButton].forEach {
            $0.snp.makeConstraints {
                $0.centerX.equalTo(guide.snp.centerX)
                $0.height.equalTo(CGFloat.dynamicYMargin(margin: 100))
                $0.width.equalTo(guide).multipliedBy(0.8)
            }
        }
        
        questionLabel.snp.makeConstraints {
            $0.centerX.equalTo(guide.snp.centerX)
            $0.top.equalTo(guide.snp.top).offset(CGFloat.dynamicYMargin(margin: 50))
            $0.width.equalTo(CGFloat.dynamicXMargin(margin: 250))
            $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
        }
        
        inActivateButton.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 10))
            
        }
        
        littleActivateButton.snp.makeConstraints {
            $0.top.equalTo(inActivateButton.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 30))
        }
        
        activateButton.snp.makeConstraints {
            $0.top.equalTo(littleActivateButton.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 30))
        }
        
        veryActivateButton.snp.makeConstraints {
            $0.top.equalTo(activateButton.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 30))
        }
    }
    
    @objc private func selectButton(_ sender: UIButton) {
        deselectAllButtons()
        sender.isSelected = true
        self.selectedItem = sender.tag
        
        let lastVC = LastUserInfoViewController()
        lastVC.selectedItem = self.selectedItem ?? 0
        
        let secondVC = SecondUserInfoViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func deselectAllButtons() {
        let buttonArr = [inActivateButton, littleActivateButton, activateButton, veryActivateButton]
        buttonArr.forEach {
            $0.isSelected = false
        }
    }
}



