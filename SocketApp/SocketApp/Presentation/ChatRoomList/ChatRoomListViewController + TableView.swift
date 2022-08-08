//
//  ChatRoomListViewController + TableView.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import UIKit

extension ChatRoomListViewController: UITableViewDelegate, UITableViewDataSource {
    // row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomArr.count
    }
    
    // row 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // row cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatRoomCell", for: indexPath) as? ChatRoomCell else {
            return UITableViewCell()
        }
        let url = URL(string: chatRoomArr[indexPath.row].profile)!
        cell.profileImg.kf.setImage(with: url)
        cell.roomNameLabel.text = chatRoomArr[indexPath.row].name
        return cell
    }
    
    // row cell 선택 이벤트 -> 화면이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let RoomVC = self.storyboard?.instantiateViewController(identifier: "RoomSB") as? RoomViewController else {
            return
        }
        RoomVC.opponentName = "\(chatRoomArr[indexPath.row].userName)"
        RoomVC.title = "\(chatRoomArr[indexPath.row].name)"
        self.navigationController?.pushViewController(RoomVC, animated: true)
        
    }
    
    
}
