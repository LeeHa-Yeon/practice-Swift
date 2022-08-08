//
//  ChatRoomViewController.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import UIKit
import RealmSwift

class ChatRoomListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let chatManager = ChatService.shared
    var chatRoomArr: [ChatModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getData()
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
   
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getData(){
        chatManager.getChatRoomAPI { response in
            self.chatRoomArr = response.data
            self.tableView.reloadData()
        }
    }
}

extension ChatRoomListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatRoomCell", for: indexPath) as? ChatRoomCell else {
            return UITableViewCell()
        }
        let url = URL(string: chatRoomArr[indexPath.row].profile)!
        cell.profileImg.kf.setImage(with: url)
        cell.roomNameLabel.text = chatRoomArr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let RoomVC = self.storyboard?.instantiateViewController(identifier: "RoomSB") as? RoomViewController else {
            return
        }
        RoomVC.opponentName = "\(chatRoomArr[indexPath.row].userName)"
        RoomVC.title = "\(chatRoomArr[indexPath.row].name)"
        self.navigationController?.pushViewController(RoomVC, animated: true)
        
    }
    
    
}

class ChatRoomCell: UITableViewCell {
//    var realm: Realm!
    
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
