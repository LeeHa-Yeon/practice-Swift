//
//  RoomViewController.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import UIKit
import Starscream
import RealmSwift
import Kingfisher

class RoomViewController: UIViewController {
    
    // MARK: - Properties
    var realm: Realm!
    var socket: WebSocket?
    var opponentName: String?
    var messages = [UserChatting]()
    
    var originBottomMargin: CGFloat = 0
    
    // MARK: - Components
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var bottomContainerMargin: NSLayoutConstraint!
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        inputTextField.resignFirstResponder()
        if let content = inputTextField.text {
            sendMessage(content)
            messages.append(UserChatting(to: "user", from: "info", message: content, type: "message"))
            updateMessage()
            
            try! realm.write({
                realm.add(UserChatting(to: "user", from: "info" , message: content, type: "message"))
            })
        }
        inputTextField.text = ""
    }
    
    // MARK: - 메모리 해제
    deinit {
        socket?.disconnect()
        socket?.delegate = nil
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setRealm()
        setUI()
        setKeyboardBottomMargin()
        connect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Function
    func setUI(){
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = UIColor.darkGray.cgColor
        inputTextField.layer.cornerRadius = 10
        inputTextField.layer.masksToBounds = true
        setNavigation()
        setTableView()
        setTextField()
    }
    
    func setNavigation(){
        self.navigationController?.view.tintColor = UIColor.black
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setTextField(){
        inputTextField.delegate = self
    }
    
    // 데이터 불러오기
    func setRealm(){
        realm = try! Realm()
        let loadMessage = realm.objects(UserChatting.self)
        
        for item in loadMessage {
            messages.append(UserChatting(to: item.to, from: item.from, message: item.message, type: item.type))
        }
    }
    
    // 메세지가 추가될 때마다 호출해야됨
    func updateMessage() {
        tableView.reloadData()
        scrollLastOfTableView()
    }
    
    // 채팅 스크롤 아래로 내리기
    func scrollLastOfTableView(){
        let lastSectionIndex = self.tableView.numberOfSections - 1
        
        let lastRowInLastSection = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let indexPath = IndexPath(row: lastRowInLastSection, section: lastSectionIndex)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

}
