//
//  MorningHeaderView.swift
//  ExMultiSectinoMultiItem
//
//  Created by Jake.K on 2022/05/27.
//

import UIKit
import SnapKit
import Then

final class MorningHeaderView: UITableViewHeaderFooterView {
  private let backgroundImageView = UIImageView().then {
    $0.isUserInteractionEnabled = false
  }
  private let label = UILabel().then {
    $0.text = ""
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
      $0.top.left.equalToSuperview()
      $0.right.lessThanOrEqualToSuperview()
      $0.size.equalTo(CGSize(width: 120, height: 80))
    }
    self.label.snp.makeConstraints {
      $0.top.equalTo(self.backgroundImageView.snp.bottom)
      $0.left.right.bottom.equalToSuperview()
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
