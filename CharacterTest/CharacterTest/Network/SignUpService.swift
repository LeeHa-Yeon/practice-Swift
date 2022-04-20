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
    
    func requestCreateUser(completion: @escaping (SignUpResponse)->(Void)){
        print(UIDevice.current.identifierForVendor!.uuidString)
        let URL = Constant.BasicURL + "/user"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
            "uuid":             UIDevice.current.identifierForVendor!.uuidString
        ]
        AF.request(URL, method: .post, headers: HEADER).responseJSON { response in
            switch response.result {
            case .success :
                
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 201 :
                        print("최초 성공했을 때")
                        do{
                            let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                            let json = try JSONDecoder().decode(SignUpResponse.SignUpSuccess.self, from: jsonData)
                            completion(SignUpResponse(type: .success, successObj: json))
                        }catch let error {
                            print(" SignUpService 201 parsing error -> \(error.localizedDescription)")
                        }
                        break
                    case 400 :
                        print("이미 등록되어있을 때")
                        do{
                            let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                            let json = try JSONDecoder().decode(SignUpResponse.SignUpFail.self, from: jsonData)
                            completion(SignUpResponse(type: .fail, failureObj: json))
                        }catch let error {
                            print(" SignUpService 400 parsing error -> \(error.localizedDescription)")
                        }
                        break
                    default :
                        print("예상치 못한 에러")
                        completion(SignUpResponse(type: .fail, failureObj: nil))
                        break
                    }
                }
            case .failure :
                print("fail, statusCode --> \(response.result)")
            }
        }
    }
}
