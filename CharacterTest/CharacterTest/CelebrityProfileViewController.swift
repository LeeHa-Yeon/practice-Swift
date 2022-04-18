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
    
    var profileWidth: Int = 60
    
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
        $0.addArrangedSubview(profileStackView)
    }
    
    var profileLabel = UILabel().then{
        $0.text = "프로필"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Bold", size: 14.0)
    }
    
    lazy var profileStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 12
        $0.addArrangedSubview(birthdayStackView)
        $0.addArrangedSubview(deceasedAtStackView)
        $0.addArrangedSubview(mbtiStackView)
        $0.addArrangedSubview(nationalityStackView)
        $0.addArrangedSubview(bodySpecStackView)
        $0.addArrangedSubview(educationStackView)
        $0.addArrangedSubview(jobStackView)
        $0.addArrangedSubview(wealthStackView)
        $0.addArrangedSubview(spouseStackView)
        $0.addArrangedSubview(childrenStackView)
    }
    
    lazy var birthdayStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(birthdayKeyLabel)
        $0.addArrangedSubview(birthdayValueLabel)
    }
    
    // 60
    var birthdayKeyLabel = UILabel().then {
        $0.text = "출생"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var birthdayValueLabel = UILabel().then {
        $0.text = "1955.02.24"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var deceasedAtStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(deceasedAtKeyLabel)
        $0.addArrangedSubview(deceasedAtValueLabel)
    }
    
    var deceasedAtKeyLabel = UILabel().then {
        $0.text = "사망"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var deceasedAtValueLabel = UILabel().then {
        $0.text = "2011.10.05"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var mbtiStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(mbtiKeyLabel)
        $0.addArrangedSubview(mbtiValueLabel)
    }
    
    var mbtiKeyLabel = UILabel().then {
        $0.text = "MBTI"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var mbtiValueLabel = UILabel().then {
        $0.text = "ENTJ"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var nationalityStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(nationalityKeyLabel)
        $0.addArrangedSubview(nationalityValueLabel)
    }
    
    var nationalityKeyLabel = UILabel().then {
        $0.text = "국적"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var nationalityValueLabel = UILabel().then {
        $0.text = "미국"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var bodySpecStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(bodySpecKeyLabel)
        $0.addArrangedSubview(bodySpecValueLabel)
    }
    
    var bodySpecKeyLabel = UILabel().then {
        $0.text = "신체"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var bodySpecValueLabel = UILabel().then {
        $0.text = "183cm 59kg"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var educationStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(educationKeyLabel)
        $0.addArrangedSubview(educationValueLabel)
    }
    
    var educationKeyLabel = UILabel().then {
        $0.text = "학력"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var educationValueLabel = UILabel().then {
        $0.text = "리드대학교 철학과 중퇴"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var jobStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(jobKeyLabel)
        $0.addArrangedSubview(jobValueLabel)
    }
    
    var jobKeyLabel = UILabel().then {
        $0.text = "직업"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var jobValueLabel = UILabel().then {
        $0.text = "기업인"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var wealthStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(wealthKeyLabel)
        $0.addArrangedSubview(wealthValueLabel)
    }
    
    var wealthKeyLabel = UILabel().then {
        $0.text = "재산"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var wealthValueLabel = UILabel().then {
        $0.text = "83억 달러(사망 당시)\n219억 달러(2021년 기준)"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var spouseStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(spouseKeyLabel)
        $0.addArrangedSubview(spouseValueLabel)
    }
    
    var spouseKeyLabel = UILabel().then {
        $0.text = "배우자"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var spouseValueLabel = UILabel().then {
        $0.text = "로렌 파월(1991~2011)"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    lazy var childrenStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
        $0.addArrangedSubview(childrenKeyLabel)
        $0.addArrangedSubview(childrenValueLabel)
    }
    
    var childrenKeyLabel = UILabel().then {
        $0.text = "자녀"
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
    }
    
    var childrenValueLabel = UILabel().then {
        $0.text = "리사 브레넌 잡스\n리드 잡스\n에린 시에나 잡스\n이브 잡스"
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        $0.textAlignment = .left
        $0.numberOfLines = 0
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
        $0.text = "- 스티브 잡스는 왼손잡이다.\r\n- 스티브잡스는 영화 기획자로서 일하며 토이스토리를 기획했다"
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
        
        
        birthdayKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        
        deceasedAtKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        
        mbtiKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        nationalityKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        bodySpecKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        educationKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        jobKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        wealthKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        spouseKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        childrenKeyLabel.snp.makeConstraints{
            $0.width.equalTo(profileWidth)
        }
        
        
    }
    
    func setUI(){
        self.view.backgroundColor = .white
    }
    
    
    //MARK: - objc Functions
}
