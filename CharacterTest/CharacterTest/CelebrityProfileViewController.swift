//
//  CelebrityProfileViewController.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/12.
//

import UIKit
import Then
import SnapKit

class CelebrityProfileViewController: UIViewController {
    
    //MARK: - UI Components
        lazy var scrollView = UIScrollView().then {
            $0.addSubview(contentView)
            $0.isScrollEnabled = true
        }
    
    lazy var contentView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 30
        $0.addArrangedSubview(firstStackView)
        $0.addArrangedSubview(secondStackView)
    }
    
    lazy var firstStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.addArrangedSubview(firstView)
        $0.addArrangedSubview(secondView)
    }
    
    lazy var secondStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 0
        $0.addArrangedSubview(thirdView)
        $0.addArrangedSubview(fourView)
    }
    
    var firstView = UIView().then {
        $0.backgroundColor = .red
    }
    
    var secondView = UIView().then {
        $0.backgroundColor = .orange
    }
    
    var thirdView = UIView().then {
        print("왜")
        $0.backgroundColor = .yellow
    }
    
    var fourView = UIView().then {
        $0.backgroundColor = .green
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setUI()
    }
    
    //MARK: - Functions
    func setLayout(){
        
        [scrollView].forEach{ view.addSubview($0) }
        
        // scrollview 를 뷰에 맞게 맞춰준다.
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(30)
        }
        
        firstView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(300)
        }
        secondView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(300)
        }
        thirdView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        fourView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(300)
        }
        
//        contentView.snp.makeConstraints{
//            $0.top.leading.trailing.equalToSuperview().inset(16)
//        }
        
        
        
        
        
        
        // contentview 는  scrollview contentLayoutGuide와 맞춘다.
        // 수직 스크롤 적용을 위해 scrollView의 width와 동일하게, height는 이와 같이 한다.
                contentView.snp.makeConstraints{
                    $0.width.equalTo(scrollView.snp.width).multipliedBy(1)
                    $0.edges.equalTo(scrollView.contentLayoutGuide)
        //            $0.height.equalTo(scrollView.snp.height)
                    $0.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        
                }
    }
    
    func setUI(){
        self.view.backgroundColor = .white
    }
    
    
    //MARK: - objc Functions
}
