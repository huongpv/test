//
//  DiaryPresenter.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol DiaryProtocol: class {
    func startLoading()
    func finishLoading()
    func setDiarys(_ diarys: [Diary])
}

class DiaryPresenter {
    private let diaryService: DiaryService
    weak private var diaryViewProtocol: DiaryProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: DiaryProtocol){
        diaryViewProtocol = viewController
    }
    
    func detachView() {
        diaryViewProtocol = nil
    }
    
    func getDiarys() {
        diaryViewProtocol?.startLoading()
        diaryService.getDiaryServices { [weak self] diarys in
            self?.diaryViewProtocol?.finishLoading()
            self?.diaryViewProtocol?.setDiarys(diarys)
        }
    }
}
