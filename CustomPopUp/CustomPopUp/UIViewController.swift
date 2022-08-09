//
//  UIViewController.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit

extension UIViewController {
    
    // 팝업창 실행
    func showPopUp(title: String? = nil, content: String? = nil, leftButtonTitle: String = "취소", leftButtonStyle: ButtonType? = nil, rightButtonTitle: String = "확인", rightButtonStyle: ButtonType? = nil, leftActionCompletion: (()-> Void)? = nil, rightActionCompletion: (()-> Void)? = nil) {

        let popUpViewController = FirstPopUpViewController(titleText: title, contentText: content, leftButtonType: leftButtonStyle, rightButtonType: rightButtonStyle)
        
        basicPopUp(popUpVC: popUpViewController, leftButtonTitle: leftButtonTitle, rightButtonTitle: rightButtonTitle, leftActionCompletion: leftActionCompletion, rightActionCompletion: rightActionCompletion)
    }
    
    // 기본 팝업창
    // button의 backgroundColor는 임시로 주입
    private func basicPopUp(popUpVC: FirstPopUpViewController,
                            leftButtonTitle: String,
                            rightButtonTitle: String,
                            leftActionCompletion: (() -> Void)?,
                            rightActionCompletion: (() -> Void)?){
        popUpVC.addActionBtn(title: leftButtonTitle, titleColor: UIColor(hex: 0x575A63)) {
            popUpVC.dismiss(animated: false, completion: leftActionCompletion)
        }
        
        popUpVC.addActionBtn(title: rightButtonTitle, titleColor: UIColor(hex: 0x5B47F4)) {
            popUpVC.dismiss(animated: false, completion: rightActionCompletion)
        }

        present(popUpVC, animated: false, completion: nil)
    }
    
}

