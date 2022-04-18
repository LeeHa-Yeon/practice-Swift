//
//  SingUpService.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Alamofire

class SignUpService {
    static let shared = SignUpService()
    
    private init(){ }
    
    func requestCreateUser(completion: @escaping (Bool)->(Void)){
        print(UIDevice.current.identifierForVendor!.uuidString)
        let URL = Constant.BasicURL + "/user"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
            "uuid":             UIDevice.current.identifierForVendor!.uuidString
        ]
        AF.request(URL, method: .post, headers: HEADER).validate(statusCode: 200..<500).validate(contentType: ["application/json"]).responseDecodable(of: SignUpResponse.self) {
            response in
            switch response.result {
            case .success :
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 201 :
                        print("최초 성공했을 때")
                        completion(true)
                        break
                    case 404 :
                        print("이미 등록되어있을 때")
                        print("서버에서 이미 등록되어있을 때 에러 번호를 지정해주면 좋을 듯")
                        completion(false)
                        break
                    default :
                        print("예상치 못한 에러")
                        completion(false)
                        break
                    }
                }
            case .failure :
                completion(false)
                print("fail, statusCode --> \(response.result)")
            }
        }
    }
}
