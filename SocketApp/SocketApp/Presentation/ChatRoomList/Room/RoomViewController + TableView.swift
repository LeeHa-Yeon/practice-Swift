//
//  RoomViewController + TableView.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import UIKit

extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
    // row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    // row 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    // row cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch messages[indexPath.row].to {
        case "user" :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as? MyMessageCell else {
                return UITableViewCell()
            }
            cell.messageLabel.text = "\(messages[indexPath.row].message)"
            return cell
        case "info" :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendMessageCell", for: indexPath) as? FriendMessageCell else {
                return UITableViewCell()
            }
            cell.nameLabel.text = opponentName
            if messages[indexPath.row].type == "message" {
                cell.messageLabel.text = "\(messages[indexPath.row].message)"
                cell.imgmessageImgView.isHidden = true
                cell.messageLabel.isHidden = false
            }else {
                let url = URL(string: messages[indexPath.row].message)
                cell.imgmessageImgView.kf.setImage(with: url)
                cell.messageLabel.isHidden = true
                cell.imgmessageImgView.isHidden = false
            }
            
            return cell
        default:
            assert(false)
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        try! realm.write {
//            realm.deleteAll()
//        }
//        tableView.reloadData()
//    }
    
}
