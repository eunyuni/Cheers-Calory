//
//  ReprotsDetailTableViewCell.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/07/01.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class ReprotsDetailTableViewCell: UITableViewCell {

  // MARK: -Identifier
  static let identifier = "ReprotsDetailTableViewCell"
  
  // MARK: -Property
  private let shadowView = UIView()
  private let titleLabel = UILabel()
  private let lineView = UIView()
  private let totalCalory = UILabel()
  
  // MARK: -init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUI()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Action
  
  func configue(title: String, totalCalory: String) {
    self.titleLabel.text = title
    self.totalCalory.text = totalCalory
  }
  
  // MARK: -setupUI
  
  private func setUI() {
    contentView.addSubviews([
    shadowView,
    
    
    
    ])
    
    shadowView.addSubviews([
    titleLabel,
    lineView,
    totalCalory
    
    ])
    
//    shadowView.layer.masksToBounds = false
    shadowView.layer.shadowColor = UIColor.black.cgColor
//    shadowView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    shadowView.layer.shadowOffset = .zero
    shadowView.layer.shadowOpacity = 0.2
    shadowView.layer.shadowRadius = 4.0
    shadowView.backgroundColor = ColorZip.lightGray3
    lineView.backgroundColor = ColorZip.purple
    
    [titleLabel, totalCalory].forEach {
      $0.textColor = ColorZip.purple
      $0.font = .systemFont(ofSize: 22, weight: .regular)
    }
    setConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setConstraint() {
    
    shadowView.snp.makeConstraints {
//      $0.leading.trailing.top.bottom.equalToSuperview().offset(8)
      $0.height.equalTo(120)
      $0.edges.equalToSuperview().offset(10)
    }
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: 28))
      $0.top.equalToSuperview().offset(CGFloat.dynamicYMargin(margin: 14))
    }
    lineView.snp.makeConstraints {
      $0.width.equalToSuperview().multipliedBy(0.9)
      $0.height.equalTo(0.8)
      $0.top.equalTo(titleLabel.snp.bottom).offset(6)
      $0.centerX.equalToSuperview()
    }
    totalCalory.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -38))
      $0.top.equalTo(titleLabel.snp.top)
    }
    
  }
  

}
