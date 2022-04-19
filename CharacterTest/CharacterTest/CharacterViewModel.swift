//
//  CharacterViewModel.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/19.
//

import Foundation

class CharacterViewModel {
    let celebrityService = CelebrityService.shared
    
    func requestData(celebrityData: @escaping (CelebrityInformation) -> (Void)){
        celebrityService.requestShowCelebrity(celebrityId: 1) { response in
            celebrityData(response.celebrityInformation)
        }
    }
    
}
