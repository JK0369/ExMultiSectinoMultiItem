//
//  DiaryCell.swift
//  ExSingleSectionMultiCell
//
//  Created by Jake.K on 2022/05/26.
//

import UIKit
import Then
import SnapKit
import RxSwift

final class DiaryCell: UITableViewCell {
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .center
    $0.distribution = .fill
    $0.spacing = 8
  }
  private let pictureImageView = UIImageView().then {
    $0.isUserInteractionEnabled = false
  }
  private let dateLabel = UILabel().then {
    $0.textColor = .systemBlue
    $0.font = .systemFont(ofSize: 20)
    $0.numberOfLines = 0
  }
  private let memoryLabel = UILabel().then {
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 18)
    $0.numberOfLines = 0
  }

  private var date: Date? {
    didSet {
      self.dateLabel.isHidden = date == nil
      guard let date = self.date else { return }
      let format = DateFormatter()
      format.locale = Locale(identifier: "ko_KR")
      format.timeZone = TimeZone(abbreviation: "KST")
      format.dateFormat = "yyyy-MM-dd"
      self.dateLabel.text = format.string(from: date)
    }
  }
  var disposeBag = DisposeBag()
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(self.stackView)
    [self.pictureImageView, self.dateLabel, self.memoryLabel]
      .forEach(self.stackView.addArrangedSubview(_:))
    
    self.stackView.snp.makeConstraints {
      $0.edges.equalToSuperview().priority(999)
    }
    self.pictureImageView.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 200, height: 120))
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.disposeBag = DisposeBag()
    self.prepare(picture: nil, date: nil, memory: nil)
  }
  
  func prepare(picture: UIImage?, date: Date?, memory: String?) {
    self.pictureImageView.image = picture
    self.date = date
    self.memoryLabel.text = memory
    
    self.pictureImageView.isHidden = picture == nil
    self.memoryLabel.isHidden = memory == nil
  }
}
