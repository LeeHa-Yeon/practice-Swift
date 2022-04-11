//
//  CharacterViewController.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/11.
//

import UIKit


class CharacterViewController: UIViewController {
    
    //MARK: - UI Components
    private var backButtonImage: UIImage? {
        return UIImage(named: "icon_back")?.withAlignmentRectInsets(UIEdgeInsets(top: -25.0, left: -20.0, bottom: 0.0, right: 0.0))
    }
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
    }
    
    //MARK: - Functions
    func setNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage) // 이미지설정
        appearance.backButtonAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 0.0)]
        self.navigationController?.navigationBar.standardAppearance = appearance // 적용
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = .white // 이미지색상
    }
    
    func setUI(){
        self.view.backgroundColor = UIColor(named:"soulMain")
    }

    //MARK: - objc Functions
    
}
