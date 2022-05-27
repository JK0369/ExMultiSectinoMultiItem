//
//  DiarySectionItemModel.swift
//  ExSingleSectionMultiCell
//
//  Created by Jake.K on 2022/05/26.
//

import RxDataSources

struct DiarySectionItem {
  typealias Model = SectionModel<DiarySection, Item>
  
  enum DiarySection: Equatable {
    case morning(TimeModel) // associative value에 들어가는 값은 section에서의 데이터 값
    case afternoon(TimeModel)
  }
  
  enum Item: Equatable {
    case oneLineSummary(String) // associative value에 들어가는 값은 item에서 데이터 값
    case memory(DiaryModel)
  }
}
