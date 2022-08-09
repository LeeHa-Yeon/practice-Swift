//
//  BasicViewController.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit


class BasicViewController: UIViewController {
    
    @IBAction func testBtnTapped(_ sender: Any) {
        showPopUp(title: "방 나가기", content: "채팅 내용은 다시 복구되지 않습니다.\n정말 나가시겠어요?", leftButtonTitle: "취소오", rightButtonTitle: "나가기", leftActionCompletion: nil) {
            print("테스트중~~")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
