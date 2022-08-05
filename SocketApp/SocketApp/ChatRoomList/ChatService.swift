//
//  ChatService.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import Foundation
import Alamofire

class ChatService {
    static let shared = ChatService()
    private init() {}
    
    func getChatRoomAPI(completion: @escaping (ChatResponse) -> (Void)){
        let para = [
            "type": "chats"
        ]
        
        AF.request(Network.BasicURL, method: .get, parameters: para).validate().responseDecodable(of:ChatResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print("채팅방 불러오기 실패 -> \(error.localizedDescription)")
            }
        }
    }
    
}


struct ChatResponse: Decodable {
    let statusCode: Int
    let data: [ChatModel]
}

struct ChatModel: Decodable {
    let name: String
    let userName: String
    let profile: String
}
