//
//  ChatRoomViewController.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import UIKit
import RealmSwift

class ChatRoomListViewController: UIViewController {
    
    // MARK: - Properties
    let chatManager = ChatService.shared
    var chatRoomArr: [ChatModel] = []
    
    // MARK: - Components
    @IBOutlet weak var tableView: UITableView!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Functions
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



