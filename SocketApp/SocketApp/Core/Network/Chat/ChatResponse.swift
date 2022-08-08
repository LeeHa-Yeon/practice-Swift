//
//  ChatResponse.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import Foundation

struct ChatResponse: Decodable {
    let statusCode: Int
    let data: [ChatModel]
}

struct ChatModel: Decodable {
    let name: String
    let userName: String
    let profile: String
}
