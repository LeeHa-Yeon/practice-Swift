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

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //MARK: - Functions

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

}

