//
//  BasicViewController.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit

class BasicViewController: UIViewController {
    
    @IBAction func testBtnTapped(_ sender: Any) {
        print("눌리는중?")
        
//        guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "popupSB") as? FirstPopUpViewController else {
//                    return
//                }
//        popupVC.modalPresentationStyle = .fullScreen
//                self.present(popupVC, animated: true)
        showPopUp(title: "타이이이이틀", content: "메세지이이이이이", leftButtonTitle: "취소오", rightButtonTitle: "화기인", leftActionCompletion: nil) {
            print("테스트중~~")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
