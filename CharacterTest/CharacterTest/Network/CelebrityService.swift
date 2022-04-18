//
//  CelebrityService.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Alamofire

class CelebrityService {
    static let shared = CelebrityService()
    
    private init(){}
    
    // 셀럽 리스트 조회 -> 현재 디코딩이 안되서 사용 불가 ( 서버 문의 )
    func requestShowCelebrityList(completion: @escaping (ShowCelebrityListResponse)->(Void)){
        let URL = Constant.BasicURL + "/celebrities"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
        ]
        
        AF.request(URL, method: .get, headers: HEADER).validate().validate(contentType: ["application/json"]).responseDecodable(of: ShowCelebrityListResponse.self) {
            response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let erorr) :
                print("fail statusCode -> \(erorr.localizedDescription)")
            }
        }
        
    }
    
    // 특정 셀럽 조회 ( ShowCelebrityResponse 루틴빼고는 성공 )
    func requestShowCelebrity(celebrityId: Int, completion: @escaping (ShowCelebrityResponse)->(Void)){
        let URL = Constant.BasicURL + "/celebrities/\(celebrityId)"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
        ]
        AF.request(URL, method: .get, headers: HEADER).validate(statusCode: 200..<500).validate(contentType: ["application/json"]).responseDecodable(of: ShowCelebrityResponse.self) {
            response in
            switch response.result {
            case .success(let successResponse) :
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200 :
                        print("성공했을때")
                        completion(successResponse)
                        break
                    case 404 :
                        print("없는 셀럽에 접근했을 때")
                        break
                    default :
                        print("예상치 못한 에러")
                        break
                    }
                }
            case .failure :
                print("fail statusCode -> \(response.result)")
            }
        }
        
    }
    
    // 특정 셀럽 체험하기 (ImitateCelebrityReqeust 부분 타입 서버에게 요청)
    func requestImitateCelebrity(celebrityId: Int, para: ImitateCelebrityReqeust, completion: @escaping (ImitateCelebrityResponse)->(Void)){
        let URL = Constant.BasicURL + "/celebrities/\(celebrityId)/imitate"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
        ]
        AF.request(URL, method: .post,parameters: para, encoder: JSONParameterEncoder(), headers: HEADER).validate(statusCode: 200..<500).validate(contentType: ["application/json"]).responseDecodable(of: ImitateCelebrityResponse.self) {
            response in
            switch response.result {
            case .success(let successResponse) :
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 201 :
                        print("성공했을때")
                        completion(successResponse)
                        break
                    default :
                        print("예상치 못한 에러")
                        break
                    }
                }
            case .failure :
                print("fail statusCode -> \(response.result)")
            }
        }
    }
    
}
