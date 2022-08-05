//
//  FirendService.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import Foundation
import Alamofire

class Network {
    static let BasicURL =  "https://7u6czzkpd6omkkpe4gipqgpxvy0vwxdn.lambda-url.ap-northeast-2.on.aws"
}

class FriendService {
    static let shared = FriendService()
    private init() {}
    
    func getFriendAPI(completion: @escaping (FriendResponse) -> (Void)){
        let para = [
            "type": "friends"
        ]
        
        AF.request(Network.BasicURL, method: .get, parameters: para).validate().responseDecodable(of:FriendResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print("친구목록 불러오기 실패 -> \(error.localizedDescription)")
            }
        }
    }
    
    func getFavoriteAPI(completion: @escaping (FriendResponse) -> (Void)){
        let para = [
            "type": "favorite"
        ]
        
        AF.request(Network.BasicURL, method: .get, parameters: para).validate().responseDecodable(of: FriendResponse.self) {
            response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print("즐겨찾기 친구 목록 불러오기 실패 -> \(error.localizedDescription)")
            }
        }
    }
    
    func getRecommendAPI(completion: @escaping (FriendResponse) -> (Void)){
        let para = [
            "type": "recommend"
        ]
        
        AF.request(Network.BasicURL, method: .get, parameters: para).validate().responseDecodable(of: FriendResponse.self) {
            response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print("추천 친구 목록 불러오기 실패 -> \(error.localizedDescription)")
            }
        }
    }
    
}


struct FriendResponse: Decodable {
    let statusCode: Int
    let data: [FriendModel]
}

struct FriendModel: Decodable {
    let name: String
    let profile: String
}
