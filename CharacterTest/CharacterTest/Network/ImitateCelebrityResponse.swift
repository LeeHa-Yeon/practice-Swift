//
//  ImitateCelebrityResponse.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Foundation

struct ImitateCelebrityResponse: Decodable {
    let imitatedUser: Int
    let celebrityName: String
}
