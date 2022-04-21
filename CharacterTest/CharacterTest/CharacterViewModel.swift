//
//  CharacterViewModel.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/19.
//

import Foundation

class CharacterViewModel {
    let celebrityService = CelebrityService.shared
    var routines: Observable2<[CelebrityRoutin]> = Observable2(value: [])
    var celebrityId: Int = 1
    
    func requestData(celebrityData: @escaping (CelebrityInformation) -> (Void)){
        celebrityService.requestShowCelebrity(celebrityId: celebrityId) { response in
            celebrityData(response.celebrityInformation)
            self.routines.value = response.celebrityInformation.celebrityRoutines
        }
    }
    
    var routinesCount: Int {
        routines.value.count
    }
    
    func getRoutinesData(idx: Int) -> CelebrityRoutin {
        self.routines.value[idx]
    }
    
}
