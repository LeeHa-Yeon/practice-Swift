//
//  ImitatedService.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Alamofire

class ImitaatedService {
    static let shared = ImitaatedService()
    
    private init() { }
    
    // 내 루틴 조회
    func requestLoadMyRoutin(completion: @escaping (ImitatedResponse)->(Void)){
        let URL = Constant.BasicURL + "/imitated/routines"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
            "uuid":     UIDevice.current.identifierForVendor!.uuidString
        ]
        
        AF.request(URL, method: .get, headers: HEADER).validate().validate(contentType: ["application/json"]).responseDecodable(of: ImitatedResponse.self) {
            response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let erorr) :
                print("fail statusCode -> \(erorr.localizedDescription)")
            }
        }
    }
    
    // 개인 루틴 개별 수정
    func requestModify(id:Int, status: Bool,completion: @escaping (ImitatedModifyResponse)->(Void)) {
        let URL = Constant.BasicURL + "/imitated/routines/\(id)"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
            "uuid":     UIDevice.current.identifierForVendor!.uuidString
        ]
        let para: ImitatedModifyRequest = ImitatedModifyRequest(isCompleted: status)
        
        AF.request(URL, method: .patch, parameters: para, encoder: JSONParameterEncoder(),headers: HEADER).validate().validate(contentType: ["application/json"]).responseDecodable(of: ImitatedModifyResponse.self) {
            response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let erorr) :
                print("fail statusCode -> \(erorr.localizedDescription)")
            }
        }
    }
    
    // 개인 루틴 개별 삭제
    func requestDelete(id:Int,completion: @escaping (Bool)->(Void)) {
        let URL = Constant.BasicURL + "/imitated/routines/\(id)"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Content-Type":     "application/json",
            "uuid":     UIDevice.current.identifierForVendor!.uuidString
        ]
        
        AF.request(URL, method: .delete, headers: HEADER).validate().validate(contentType: ["application/json"]).responseJSON {
            response in
            switch response.result {
            case .success :
                completion(true)
            case .failure(let erorr) :
                print("fail statusCode -> \(erorr.localizedDescription)")
            }
        }
    }
}
