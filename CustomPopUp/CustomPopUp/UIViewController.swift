//
//  UIViewController.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit

extension UIViewController {
    func showPopUp(title: String? = nil, content: String? = nil, leftButtonTitle: String = "취소", rightButtonTitle: String = "확인", leftActionCompletion: (()-> Void)? = nil, rightActionCompletion: (()-> Void)? = nil) {

        
        // TODO: - 이 부분은 나중에 커스텀 버튼 만들고나서는 삭제될 부분 //
        let leftButtonStyle = UIButton()
        leftButtonStyle.titleLabel?.font = .systemFont(ofSize: 16.0)
        leftButtonStyle.setTitle(leftButtonTitle, for: .normal)
        leftButtonStyle.setTitleColor(.darkGray, for: .normal)
        leftButtonStyle.layer.cornerRadius = 4.0
        leftButtonStyle.layer.masksToBounds = true
        
        let rightButtonStyle = UIButton()
        rightButtonStyle.titleLabel?.font = .systemFont(ofSize: 16.0)
        rightButtonStyle.setTitle(rightButtonTitle, for: .normal)
        rightButtonStyle.setTitleColor(.purple, for: .normal)
        rightButtonStyle.layer.cornerRadius = 4.0
        rightButtonStyle.layer.masksToBounds = true
        // --------------------------------------------- //
        
        
        let popUpViewController = FirstPopUpViewController(test: "gg")
        
        basicPopUp(popUpVC: popUpViewController, leftActionCompletion: leftActionCompletion, rightActionCompletion: rightActionCompletion)
        
    }
    
    private func basicPopUp(popUpVC: FirstPopUpViewController,
                            leftActionCompletion: (() -> Void)?,
                            rightActionCompletion: (() -> Void)?){
        popUpVC.buttonAction(location: .left) {
            popUpVC.dismiss(animated: false, completion: leftActionCompletion)
        }
        
        popUpVC.buttonAction(location: .right) {
            popUpVC.dismiss(animated: false, completion: rightActionCompletion)
        }
        
        
        present(popUpVC, animated: false, completion: nil)
    }
    
}

