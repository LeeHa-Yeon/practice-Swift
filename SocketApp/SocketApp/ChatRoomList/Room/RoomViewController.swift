//
//  RoomViewController.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import UIKit
import Starscream

class RoomViewController: UIViewController {
    
    var socket: WebSocket?
    private var originBottomMargin: CGFloat = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bottomContainerMargin: NSLayoutConstraint!
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        inputTextField.resignFirstResponder()
        if let content = inputTextField.text {
            sendMessage(content)
            messages.append(MessageWithType(content: content, type: .user))
            updateMessage()
        }
        inputTextField.text = ""
    }
    var messages = [MessageWithType]()
    
    deinit {
        socket?.disconnect()
        socket?.delegate = nil
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTableView()
        setData()
        setUI()
        setKeyboardBottomMargin()
        setTextField()
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
        
    }
    
    func setNavigation(){
        navigationItem.backButtonTitle = ""
    }
    
    func setTextField(){
        inputTextField.delegate = self
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 채팅 스크롤 아래로 내리기
    func scrollLastOfTableView(){
        let lastSectionIndex = self.tableView.numberOfSections - 1
        
        let lastRowInLastSection = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let indexPath = IndexPath(row: lastRowInLastSection, section: lastSectionIndex)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    // 메세지가 추가될 때마다 호출해야됨
    func updateMessage() {
        tableView.reloadData()
        scrollLastOfTableView()
    }
    
    func setData(){
        messages.append(MessageWithType(content: "안녕안녕", type: .user))
        messages.append(MessageWithType(content: "반가워", type: .user))
        messages.append(MessageWithType(content: "안녕!!", type: .info))
        messages.append(MessageWithType(content: "좋은 아침이야", type: .info))
        messages.append(MessageWithType(content: "뭐하고있어?", type: .info))
        messages.append(MessageWithType(content: "오늘 휴가 ~", type: .user))
        messages.append(MessageWithType(content: "부럽당부럽당부럽당부럽당부럽당부럽당부럽당부럽당부럽당부럽당부럽당부럽당부럽당부럽당", type: .info))
        messages.append(MessageWithType(content: "ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ", type: .user))
    }
    
}

extension RoomViewController: WebSocketDelegate {
    
    // WebSocket 서버에 연결하는 부분
    func connect() {
        let url = "wss://yxpx35wxx4.execute-api.ap-northeast-2.amazonaws.com/production"
        
        var request = URLRequest(url: URL(string: url)!)
        request.timeoutInterval = 10
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    // WebSocket 서버 연결 끊는 부분
    func disconnect() {
        socket?.disconnect()
    }
    
    // 메세지 발신 -> 버튼을 탭할 때 이 메소드 호출
    func sendMessage(_ message: String) {
        let para = ["action": "sendmessage", "message":"\(message)"]
        do {
            let data = try JSONSerialization.data(withJSONObject: para)
            if let dataString = String(data: data, encoding: .utf8) {
                self.socket?.write(string: dataString)
            }
        } catch {
            print("JSON serialization failed: ",error)
        }
    }
    
    // 메시지 수신
    func receivedMessage(_ message: String) {
        messages.append(MessageWithType(content: message, type: .info))
        updateMessage()

    }
    
    // 메시지 받는 부분
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch(event) {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let text):
            print("received text----> \(text)")
            
            guard let data = text.data(using: .utf8),
                  let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let messageType = jsonData["message"] as? String else {
                return
            }
            self.receivedMessage(messageType)
            
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            print("websocket is canclled")
            
        case .error(let error) :
            print("websocket is error = \(error!)")
            
        }
    }
}



extension RoomViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RoomViewController {
    func setKeyboardBottomMargin(){
        originBottomMargin = self.bottomContainerMargin.constant
        addNotification()
    }
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            
            UIView.animate(withDuration: animationDuration){
                self.bottomContainerMargin.constant = keyboardHeight - self.view.safeAreaInsets.bottom + 10
                self.view.layoutIfNeeded()
                self.scrollLastOfTableView()
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let animvationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animvationDuration) {
            self.bottomContainerMargin.constant = self.originBottomMargin
            self.view.layoutIfNeeded()
        }
    }
}

extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch messages[indexPath.row].type {
        case .user :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as? MyMessageCell else {
                return UITableViewCell()
            }
            cell.messageLabel.text = "\(messages[indexPath.row].content)"
            return cell
        case .info :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendMessageCell", for: indexPath) as? FriendMessageCell else {
                return UITableViewCell()
            }
            cell.messageLabel.text = "\(messages[indexPath.row].content)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


class FriendMessageCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
    }
    
    
}


class MyMessageCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
}

enum MessageType {
    case user
    case info
}


struct MessageWithType {
    var content: String
    var type: MessageType
    
    init(content: String, type: MessageType){
        self.content = content
        self.type = type
    }
}
