//
//  FriendResponse.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import Foundation

struct FriendResponse: Decodable {
    let statusCode: Int
    let data: [FriendModel]
}

struct FriendModel: Decodable {
    let name: String
    let profile: String
}
