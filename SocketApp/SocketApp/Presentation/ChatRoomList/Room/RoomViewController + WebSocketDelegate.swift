//
//  RoomViewController + WebSocketDelegate.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import Foundation
import Starscream

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
    func receivedMessage(_ message: String, _ type: String) {
        messages.append(UserChatting(to: "info", from: "user", message: message, type: type))
        try! realm.write({
            realm.add(UserChatting(to: "info", from: "user" , message: message, type: type))
        })
        updateMessage()

    }
    
    // 모든 WebSocket 이벤트를 수신
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch(event) {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let text):
            print("received text----> \(text)")
            
            guard let data = text.data(using: .utf8),
                  let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                   else { return }
            guard let messageType = jsonData["message"] as? String else {
                guard let imageType = jsonData["image"] as? String else {
                    return
                }
                self.receivedMessage(imageType, "image")
                return
            }
            self.receivedMessage(messageType, "message")
            
            
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
