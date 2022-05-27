//
//  AfternoonHeaderView.swift
//  ExMultiSectinoMultiItem
//
//  Created by Jake.K on 2022/05/27.
//

import UIKit
import SnapKit
import Then

final class AfternoonHeaderView: UITableViewHeaderFooterView {
  private let backgroundImageView = UIImageView().then {
    $0.isUserInteractionEnabled = false
  }
  private let label = UILabel().then {
    $0.textColor = .orange
    $0.font = .systemFont(ofSize: 24, weight: .bold)
    $0.numberOfLines = 0
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    self.addSubview(self.backgroundImageView)
    self.addSubview(self.label)
    
    self.backgroundImageView.snp.makeConstraints {
      $0.left.equalToSuperview()
      $0.top.greaterThanOrEqualToSuperview()
      $0.bottom.lessThanOrEqualToSuperview()
      $0.size.equalTo(CGSize(width: 120, height: 80))
    }
    self.label.snp.makeConstraints {
      $0.left.equalTo(self.backgroundImageView.snp.right)
      $0.top.bottom.right.equalToSuperview()
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.prepare(image: nil, text: nil)
  }
  
  func prepare(image: UIImage?, text: String?) {
    self.backgroundImageView.image = image
    self.label.text = text
  }
}
