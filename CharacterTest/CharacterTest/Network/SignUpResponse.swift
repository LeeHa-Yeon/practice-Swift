//
//  SignUpResponse.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/16.
//

import Foundation

enum SignUpResponseType {
    case success
    case fail
}

struct SignUpResponse {
    var type: SignUpResponseType
    var signUpSuccess: SignUpSuccess?
    var signUpFailure: SignUpFail?
    
    struct SignUpSuccess: Codable {
        let id: Int
        let uuid: String
    }
    
    struct SignUpFail: Codable {
        /**
            회원가입이 올바르지 않을 경우
         1. 중복된 회원가입 -> "가입된 유저가 존재합니다."
         */
        var errorMessage: String
    }
    
    init(type: SignUpResponseType, successObj: SignUpSuccess?){
        self.type = type
        self.signUpSuccess = successObj
    }
    
    init(type: SignUpResponseType, failureObj: SignUpFail?){
        self.type = type
        self.signUpFailure = failureObj
    }
}
