//
//  ChatRoomCell.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import UIKit
import RealmSwift

class ChatRoomCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setRealm()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
    }
    
    func setRealm(){
        let db = try! Realm()
        if db.objects(UserChatting.self).count > 0 {
            if db.objects(UserChatting.self).last?.type == "message" {
                lastMessageLabel.text = db.objects(UserChatting.self).last?.message
            }else {
                lastMessageLabel.text = "사진을 보냈습니다."
            }
            
        }else {
            lastMessageLabel.text = ""
        }
        
    }
}
