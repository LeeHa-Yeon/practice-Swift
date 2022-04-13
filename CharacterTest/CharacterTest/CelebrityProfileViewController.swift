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
        $0.showsVerticalScrollIndicator = false
    }
    
    lazy var contentView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 34
        $0.addArrangedSubview(firstStackView)
        $0.addArrangedSubview(secondStackView)
        $0.addArrangedSubview(thirdStackView)
        $0.addArrangedSubview(lastStackView)
        $0.addArrangedSubview(spaceView)
    }
    
    lazy var firstStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.addArrangedSubview(shortIntroduceLabel)
        $0.addArrangedSubview(introduceContentLabel)
    }
    
    var shortIntroduceLabel = UILabel().then {
        $0.text = "한 줄 소개"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Bold", size: 14.0)
    }
    
    var introduceContentLabel = UILabel().then {
        $0.text = "미국 애플(Apple)사의 설립자 겸 CEO를 지낸 사업가"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.numberOfLines = 0
        $0.textAlignment = .natural
    }
    
    lazy var secondStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.addArrangedSubview(wiseSayingLabel)
        $0.addArrangedSubview(wiseSayingView)
    }
    
    var wiseSayingLabel = UILabel().then{
        $0.text = "명언"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Bold", size: 14.0)
    }
    
    var wiseSayingView = UIView().then {
        $0.backgroundColor = UIColor(named: "soulSub")
    }
    
    var sayingEnglishLabel = UILabel().then {
        $0.text = "Stay hungry, Stay foolish"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Bold", size: 16.0)
        $0.textAlignment = .center
    }
    
    var sayingKoreaLabel = UILabel().then {
        $0.text = "항상 갈망하라, 그리고 늘 우직하라"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 12.0)
        $0.textAlignment = .center
    }
    
    lazy var thirdStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.addArrangedSubview(profileLabel)
        $0.addArrangedSubview(fourView)
    }
    
    var profileLabel = UILabel().then{
        $0.text = "프로필"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Bold", size: 14.0)
    }
    
//    var profileStackView = UIStackView().then {
//        $0.axis = .vertical
//        $0.distribution = .equalSpacing
//        $0.spacing = 12
//    }
    
    var fourView = UIView().then {
        $0.backgroundColor = .green
    }
    
    lazy var lastStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.addArrangedSubview(tmiLabel)
        $0.addArrangedSubview(tmiContent)
    }
    
    
    var tmiLabel = UILabel().then{
        $0.text = "TMI"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Bold", size: 14.0)
    }
    
    var tmiContent = UILabel().then {
        $0.text = "- 스티브 잡스는 왼손잡이다.\n- 스티브 잡스는 영화 기획자로서 일하며\n   토이스토리를 기획했다."
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.numberOfLines = 0
    }
    
    var spaceView = UIView().then {
        $0.backgroundColor = .clear
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
        [sayingEnglishLabel,sayingKoreaLabel].forEach{ wiseSayingView.addSubview($0)}
        
        fourView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        spaceView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        // scrollview 를 뷰에 맞게 맞춰준다.
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }

        contentView.snp.makeConstraints{
            $0.width.equalTo(scrollView.snp.width).multipliedBy(1)
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        sayingEnglishLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        sayingKoreaLabel.snp.makeConstraints{
            $0.top.equalTo(sayingEnglishLabel.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    func setUI(){
        self.view.backgroundColor = .white
    }
    
    
    //MARK: - objc Functions
}
