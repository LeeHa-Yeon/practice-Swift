//
//  TodoViewModel.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/19.
//

import Foundation

class TodoViewModel{
    let imitatedService = ImitaatedService.shared
    var routines: Observable2<[RoutinResponse]> = Observable2(value: [])
    var leftCount: Observable2<Int> = Observable2(value: 0)
    
    // 데이터 로드
    func requestData(resultData: @escaping (ImitatedResponse)->(Void)){
        imitatedService.requestLoadMyRoutin { response in
            self.routines.value = response.routines
            self.leftCount.value = response.routineCount
            resultData(response)
        }
    }
    
    // 완료 상태 수정
    func requestModify(routinId: Int, idx: Int, status: Bool){
        imitatedService.requestModify(id: routinId, status: status) { response in
            self.routines.value[idx].isCompleted = !self.routines.value[idx].isCompleted
            if status {
                self.leftCount.value -= 1
            }else {
                self.leftCount.value += 1
            }
            print("성공")
        }
    }
    
    // 데이터 삭제
    func requestDelete(routinId: Int, idx: Int, status: Bool) {
        imitatedService.requestDelete(id: routinId) { _ in
            self.deleteRoutinesData(idx: idx)
            if status {
                self.leftCount.value = self.leftCount.value
            }else {
                self.leftCount.value -= 1
            }
            print("삭제되었습니당")
        }
    }
    
    var getLeftCount: Int {
        leftCount.value
    }
    
    var routinesCount: Int {
        routines.value.count
    }
    
    func getRoutinesData(idx: Int) -> RoutinResponse {
        self.routines.value[idx]
    }
    
    func deleteRoutinesData(idx: Int) {
        self.routines.value.remove(at: idx)
    }
}
