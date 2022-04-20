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
    var isCompleted: Bool
    let time: String
    let content: String
}
