//
//  ViewController.swift
//  ExMultiSectinoMultiItem
//
//  Created by Jake.K on 2022/05/26.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
  private let tableView = UITableView(frame: .zero).then {
    $0.allowsSelection = false
    $0.backgroundColor = UIColor.clear
    $0.separatorStyle = .none
    $0.bounces = true
    $0.showsVerticalScrollIndicator = true
    $0.contentInset = .zero
    $0.register(MorningHeaderView.self, forHeaderFooterViewReuseIdentifier: "MorningHeaderView")
    $0.register(AfternoonHeaderView.self, forHeaderFooterViewReuseIdentifier: "AfternoonHeaderView")
    
    $0.register(DiaryCell.self, forCellReuseIdentifier: "DiaryCell")
    $0.register(OneLineMemoryCell.self, forCellReuseIdentifier: "OneLineMemoryCell")
    $0.estimatedRowHeight = UITableView.automaticDimension
  }
  
  private let disposeBag = DisposeBag()
  var data: [DiarySectionItem.Model] = [
    .init( // morning 섹션
      model: .morning(.init(image: UIImage(named: "morning"), name: "아침 일기")),
      items: [ // morning 섹션 안에 item들
        .oneLineSummary("오늘 아침에 맛있는걸 먹었다"),
        .memory(.init(date: Date(), memory: "샌드위치 냠냠", picture: UIImage(named: "sandwich"))),
        .memory(.init(date: nil, memory: "추가 메모 사항...", picture: nil))
      ]
    ),
    .init( // afternoon 섹션
      model: .afternoon(.init(image: UIImage(named: "afternoon"), name: "오후 일기")),
      items: [ // afternoon 섹션 안에 item들
        .oneLineSummary("RxDataSources 적용 후기"),
        .memory(.init(date: Date(), memory: "UITableViewDataSource를 사용하면 코드가 분리 되지만 RxDataSources를 사용하면 바인딩을 한꺼번에 몰아서 할 수 있어서 편리하다", picture: UIImage(named: "iPhone"))),
        .memory(.init(date: nil, memory: "n-Section, n-item일땐 RxDataSouces를 사용하고 1-Section, n-items일땐 RxSwift에서 제공하는 tableView.rx.items를 사용하면 좋을 것", picture: nil))
      ]
    ),
    .init( // morning 섹션
      model: .morning(.init(image: UIImage(named: "morning"), name: "아침에 일기")),
      items: [ // morning 섹션 안에 item들
        .oneLineSummary("행복한 하루"),
        .memory(.init(date: Date(), memory: "jake iOS 오늘은 iOS 공부를 하면서 블로그에 글도 쓰고 \n여러가지 일도 코딩을 해보았다", picture: UIImage(named: "iPhone"))),
        .memory(.init(date: nil, memory: "추가 메모 사항...", picture: nil))
      ]
    )
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints {
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }
    
    // binding
    let dataSource = RxTableViewSectionedReloadDataSource<DiarySectionItem.Model> { dataSource, tableView, indexPath, item in
      switch item {
      case let .memory(diaryModel):
        return (tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryCell).then {
          $0.prepare(
            picture: diaryModel.picture,
            date: diaryModel.date,
            memory: diaryModel.memory
          )
        }
      case let .oneLineSummary(text):
        return (tableView.dequeueReusableCell(withIdentifier: "OneLineMemoryCell", for: indexPath) as! OneLineMemoryCell).then {
          $0.prepare(text: text)
        }
      }
    }

    Observable.just(self.data)
      .bind(to: self.tableView.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
    
    // Header, Footer는 UITableViewDataSource가 아닌 UITableViewDelegate에 위치해있으므로 직접 정의
    self.tableView.delegate = self
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch self.data[section].model {
    case let .morning(model):
      return (tableView.dequeueReusableHeaderFooterView(withIdentifier: "MorningHeaderView") as! MorningHeaderView).then {
        $0.prepare(image: model.image, text: model.name)
      }
    case let .afternoon(model):
      return (tableView.dequeueReusableHeaderFooterView(withIdentifier: "AfternoonHeaderView") as! AfternoonHeaderView).then {
        $0.prepare(image: model.image, text: model.name)
      }
    }
  }
}
