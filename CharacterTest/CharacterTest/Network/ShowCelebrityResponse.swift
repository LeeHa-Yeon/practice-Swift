//
//  ShowCelebrityResponse.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Foundation

struct ShowCelebrityResponse: Decodable {
    let celebrityInformation: CelebrityInformation
}

struct CelebrityInformation: Decodable {
    let id: Int
    let name: String
    let englishName: String
    let image: String
    let job: CelebrityJob
    let MBTI: String
    let nationality: String
    let introduction: String
    let bodySpec: CelebrityBodySpec
    let education: String
    let wiseSaying: CelebrityWiseSaying
    let wealth: String
    let spouse: String
    let children: String
    let celebrityRoutines: [CelebrityRoutin]
    let age: Int
    let birthday: String
    let deceasedAt: String
    let tmi: [TMIString]
}

struct CelebrityJob: Decodable {
    let name: String
    let backgroundColor: String
    let textColor: String
}

struct CelebrityBodySpec: Decodable {
    let height: String
    let weight: String
}

struct CelebrityWiseSaying: Decodable {
    let english: String
    let korean: String
}

struct CelebrityRoutin: Decodable {
    let id: Int
    let time: String
    let content: String
}

struct TMIString: Decodable {
    let content: String
}
