//
//  ViewController.swift
//  CustomAlert
//
//  Created by 이하연 on 2022/03/21.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBAction func testBtn(_ sender: Any) {
        let customView2 = AlertView(frame: view.bounds)
//        customView2.popupAlert(content: "로그인 없이 사용할 경우,\n앱 재설치 및 기기 변경 시\n기존 데이터가 사라집니다.",myView: customView2)
        customView2.popupAlert(firstBtnTitle: "취소", secondBtnTitle: "회원가입", content: "회원가입이 필요한 서비스입니다.",myView: customView2)
//        customView2.calendarAlert(currentYear: "2022", currentMonth: "5",myView: customView2)
        customView2.delegate = self
        view.addSubview(customView2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}

protocol AlertViewDelegate {
    func cancleButtonTapped(_ sender: UIButton,_ test: UIView)
    func okButtonTapped(_ sender: UIButton, _ test: UIView)
}

extension ViewController: AlertViewDelegate {
    func cancleButtonTapped(_ sender: UIButton, _ test: UIView) {
        test.removeFromSuperview()
    }
    
    func okButtonTapped(_ sender: UIButton, _ test: UIView) {
        test.removeFromSuperview()
    }
    
}
