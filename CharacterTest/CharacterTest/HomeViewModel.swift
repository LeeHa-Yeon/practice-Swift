//
//  HomeViewModel.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/21.
//

import Foundation

class HomeViewModel {
    let celebrityService = CelebrityService.shared
    let imitatedService = ImitaatedService.shared
    // 내 루틴이 있는지 확인
    var myRoutines: Observable2<[RoutinResponse]> = Observable2(value: [])
    // 샐럽 리스트
    var celebrityList: Observable2<[CelebrityDTO]> = Observable2(value: [])
    
    
    func requestCelebrityList(){
        celebrityService.requestShowCelebrityList { response in
            self.celebrityList.value = response.celebrityInformationList
        }
    }
    
    func requestLoadMyRoutin(completion: @escaping (Bool)->(Void)){
        imitatedService.requestLoadMyRoutin { response in
            if response.routines.isEmpty {
                completion(false)
            }else {
                completion(true)
            }
        }
    }
    
    
    
    var celebrityCount: Int {
        celebrityList.value.count
    }
    
    func getCelebrityData(idx: Int) -> CelebrityDTO {
        self.celebrityList.value[idx]
    }
    
}
