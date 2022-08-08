//
//  ChatModel.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import Foundation
import RealmSwift

class UserChatting: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var to: String
    @Persisted var from: String
    @Persisted var message: String
    @Persisted var type: String
    
    
    convenience init(to: String, from: String, message: String, type: String) {
        self.init()
        
        self.to = to
        self.from = from
        self.message = message
        self.type = type
    }
    
}
