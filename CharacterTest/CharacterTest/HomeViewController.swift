//
//  ViewController.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/11.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController {
    
    //MARK: - UI Components
    lazy var myRoutinBarButton = UIBarButtonItem().then{
        $0.image = UIImage(named:"icon_profile")
        $0.style = .plain
        $0.tintColor = UIColor(named: "soulMain")
        $0.target = self
        $0.action = #selector(moveToVC(sender:))
    }
    
    lazy var testButton = UIButton().then {
        $0.setTitle("눌러", for: .normal)
        $0.backgroundColor = .blue
        $0.addTarget(self, action: #selector(testAlert(_:)), for: .touchUpInside)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setUI()
    }
    
    //MARK: - Functions
    
    func setLayout(){
        [testButton].forEach{ self.view.addSubview($0)}
        
        testButton.snp.makeConstraints{
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    func setUI(){
        self.view.backgroundColor = .white
        setNavigation()
    }
    
    func setNavigation(){
        navigationItem.rightBarButtonItem = myRoutinBarButton
    }
    
    //MARK: - objc Functions
    @objc func moveToVC(sender: UIBarButtonItem){
        let CharacterVC = CharacterViewController()
        self.navigationController?.pushViewController(CharacterVC, animated: true)
    }
    
    @objc func testAlert(_ sender: UIButton){
        let popupView = AlertView(frame: view.bounds)
        //        popupView.okButton.isHidden = true
        popupView.popupAlert(iconStyle: .questionIcon, title: "스티브 잡스를 체험하시겠어요?", message: "셀럽은 하루에 한 명씩만 체험할 수 있습니다.", firstBtnTitle: "뒤로가기", secondBtnTitle: "체험하기", myView: popupView)
        popupView.delegate = self
        view.addSubview(popupView)
    }
}

extension HomeViewController: CustomAlertProtocol {
    
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
        print("체험중~~")
    }
    
    
}
