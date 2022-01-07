//
//  DetailListBackGroundViewModel.swift
//  FindMyCVS
//
//  Created by 장기화 on 2022/01/07.
//

import RxSwift
import RxCocoa

struct DetailListBackGroundViewModel {
    //viewModel -> view
    let isStatusLabelHidden: Signal<Bool>
    
    //외부에서 전달받을 값
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
