//
//  OneLineMemoryCell.swift
//  ExMultiSectinoMultiItem
//
//  Created by Jake.K on 2022/05/27.
//

import UIKit
import Then
import SnapKit
import RxSwift

final class OneLineMemoryCell: UITableViewCell {
  private let label = UILabel().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 24)
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }
  
  var disposeBag = DisposeBag()
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(self.label)
    
    self.label.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(16)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.disposeBag = DisposeBag()
    self.prepare(text: nil)
  }
  
  func prepare(text: String?) {
    self.label.text = text
  }
}
