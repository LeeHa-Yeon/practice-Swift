//
//  ImitatedResponse.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Foundation

struct ImitatedResponse: Decodable {
    let routineCount: Int
    let celebrityName: String
    let routines: [RoutinResponse]
}

struct RoutinResponse: Decodable {
    let id: Int
//    let content: 이 부분 수정 필요
    let isCompleted: Bool
    let imitatedUser: Int
    let celebrity: Int
}
