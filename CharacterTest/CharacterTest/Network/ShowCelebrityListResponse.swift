//
//  ShowCelebrityListResponse.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Foundation

struct ShowCelebrityListResponse: Decodable {
    let list: [CelebrityDTO]
}

struct CelebrityDTO: Decodable {
    let id: Int
    let name: String
    let englishName: String
    let image: String
    let job: CelebrityJob
    let nationality: String
}
