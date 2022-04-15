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
        popupView.popupAlert(iconStyle: .exclamationIcon, title: "아직 체험할 셀럽을 정하지 않았어요!", message: "홈 화면에서 오늘 체험하고 싶은 셀럽을 선택해주세요. ", firstBtnTitle: nil, secondBtnTitle: "확인", myView: popupView)
        popupView.cancelButton.isHidden = true
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
