//
//  RoomViewController + UITextFieldDelegate.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import UIKit

extension RoomViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
