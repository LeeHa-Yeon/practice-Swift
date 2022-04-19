//
//  CharacterViewController.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/11.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class CharacterViewController: UIViewController {
    
    let viewModel = CharacterViewModel()
    
    //MARK: - UI Components
    // 상단
    private var backButtonImage: UIImage? {
        return UIImage(named: "icon_back")?.withAlignmentRectInsets(UIEdgeInsets(top: -25.0, left: -20.0, bottom: 0.0, right: 0.0))
    }
    
    lazy var celebrityImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var koreaNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Bold", size: 24.0)
    }
    
    lazy var subSmallStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        // TODO: - 구분선과 (영어이름,국적) 간격이 설정되지 않았음 ( 디자이너께 문의 )
        $0.spacing = 5
        $0.addArrangedSubview(englishNameLabel)
        $0.addArrangedSubview(separaterView)
        $0.addArrangedSubview(countryLabel)
    }
    
    lazy var englishNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    lazy var separaterView = UIView().then{
        $0.backgroundColor = .white
    }
    
    lazy var countryLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    lazy var hashTagView = UIView().then {
        $0.addSubview(careerLabel)
        $0.layer.cornerRadius = 4
    }
    lazy var careerLabel = UILabel().then {
        $0.textColor = UIColor(named: "soulNegative")
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    
    // 내용
    lazy var bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
        $0.addSubview(dismissIndicatorView)
        $0.addSubview(choseStackView)
        $0.addSubview(soulRoutinContainerView)
        $0.addSubview(profileContainerView)
    }
    
    lazy var dismissIndicatorView = UIView().then {
        $0.backgroundColor = UIColor(named: "soulGray2")
        $0.layer.cornerRadius = 3
    }
    
    lazy var choseStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.addArrangedSubview(profileButtonView)
        $0.addArrangedSubview(soulRoutinButtonView)
    }
    
    lazy var profileButtonView = UIView().then {
        $0.backgroundColor = .clear
        $0.addSubview(profileButton)
    }
    
    lazy var soulRoutinButtonView = UIView().then {
        $0.backgroundColor = .clear
        $0.addSubview(soulRoutinButton)
    }
    
    lazy var profileButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.setTitle("프로필", for: .normal)
        $0.setTitleColor(UIColor(named: "soulMain"), for: .normal)
        $0.backgroundColor = UIColor(named: "soulSub")
        $0.clipsToBounds = true
        $0.tag = 1
        $0.addTarget(self, action: #selector(changeContainer(_:)), for: .touchUpInside)
    }
    
    lazy var soulRoutinButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        $0.setTitle("소울 루틴", for: .normal)
        $0.setTitleColor(UIColor(named: "soulGray1"), for: .normal)
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.tag = 2
        $0.addTarget(self, action: #selector(changeContainer(_:)), for: .touchUpInside)
    }
    
    lazy var profileContainerView = UIView()
    
    lazy var soulRoutinContainerView = UIView()
    /////////
    
    // 하단
    lazy var fixBottomView = UIView().then {
        $0.backgroundColor = UIColor(named:"soulMain")
        // TODO: - 뷰의 radius 47 -> 32로 설정 ( 디자이너께 문의 )
        $0.layer.cornerRadius = (32.0 * (self.view.frame.width - 40.0)) / 350.0
        $0.addSubview(tryOutButton)
        self.view.bringSubviewToFront($0)
    }
    lazy var tryOutButton = UIButton().then {
        $0.setTitle("스티브 잡스처럼 살아보기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(moveToVC(_:)), for: .touchUpInside)
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setNavigation()
        setLayout()
        setUI()
        setContainerView()
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
    
    func setLayout(){
        [celebrityImageView,koreaNameLabel,subSmallStackView,hashTagView,bottomSheetView,fixBottomView].forEach { self.view.addSubview($0) }
        
        // MARK: - 상단
        
        celebrityImageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.height.equalTo(78)
        }
        
        koreaNameLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(celebrityImageView.snp.bottom).offset(22)
        }
        
        subSmallStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(koreaNameLabel.snp.bottom).offset(6)
        }
        
        separaterView.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        
        hashTagView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subSmallStackView.snp.bottom).offset(22)
            // TODO: - 너비,높이가 고정된 크기인지 ( 디자이너께 문의 )
            $0.width.equalTo(42)
            $0.height.equalTo(20)
        }
        
        careerLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        
        // MARK: - 바텀시트
        
        bottomSheetView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(hashTagView.snp.bottom).offset(38)
        }
        
        dismissIndicatorView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(14)
            $0.height.equalTo(4)
            $0.width.equalTo(66)
        }
        
        choseStackView.snp.makeConstraints{
            $0.top.equalTo(dismissIndicatorView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(34)
        }
        profileButton.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.greaterThanOrEqualTo(71)
            $0.height.equalTo(34)
        }
        soulRoutinButton.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.greaterThanOrEqualTo(90)
            $0.height.equalTo(34)
        }
        
        
        profileContainerView.snp.makeConstraints{
            $0.top.equalTo(choseStackView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        soulRoutinContainerView.snp.makeConstraints{
            $0.top.equalTo(choseStackView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        // MARK: - oo처럼 살아보기
        
        fixBottomView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(26)
            $0.height.equalTo(61)
        }
        
        tryOutButton.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(0)
        }
    }
    
    func setContainerView(){
        let CelebrityProfileVC = CelebrityProfileViewController()
        self.addChild(CelebrityProfileVC)
        self.profileContainerView.addSubview(CelebrityProfileVC.view)
        CelebrityProfileVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        CelebrityProfileVC.didMove(toParent: self)
        
        let CelebrityRoutinVC = CelebrityRoutinViewController()
        self.addChild(CelebrityRoutinVC)
        self.soulRoutinContainerView.addSubview(CelebrityRoutinVC.view)
        CelebrityRoutinVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        CelebrityRoutinVC.didMove(toParent: self)
    }
    
    func setUI(){
        self.view.backgroundColor = UIColor(named:"soulMain")
        
        celebrityImageView.layer.cornerRadius = 78 / 2
        celebrityImageView.layer.borderWidth = 1
        celebrityImageView.layer.borderColor = UIColor.clear.cgColor
        
        profileButton.layer.borderWidth = 1
        profileButton.layer.borderColor = UIColor.clear.cgColor
        profileButton.layer.cornerRadius = 15
    }
    
    func changeButtonStatus(_ button: UIButton,_ isFontBold: Bool, _ fontSize: CGFloat){
        if isFontBold {
            button.setTitleColor(UIColor(named:"soulMain"), for: .normal)
            button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: fontSize)
            button.backgroundColor = UIColor(named:"soulSub")
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.cornerRadius = 15
        }else {
            button.setTitleColor(UIColor(named:"soulGray1"), for: .normal)
            button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: fontSize)
            button.backgroundColor = .clear
        }
    }
    
    func setData(){
        viewModel.requestData { response in
            self.urlToImg(urlStr: response.image, img: self.celebrityImageView)
            self.koreaNameLabel.text = response.name
            self.englishNameLabel.text = response.englishName
            self.countryLabel.text = response.nationality
            self.hashTagView.backgroundColor = UIColor(named: response.job.backgroundColor)
            self.careerLabel.textColor = UIColor(named: response.job.textColor)
            self.careerLabel.text = response.job.name
            
        }
    }
    
    func urlToImg(urlStr: String, img: UIImageView){
        if let url: URL = URL(string: urlStr ){
            img.kf.indicatorType = .activity
            img.kf.setImage(with:url)
        }
    }
    
    //MARK: - objc Functions
    @objc func moveToVC(_ sender: UIButton){
        let TodoVC = TodoViewController()
        self.navigationController?.pushViewController(TodoVC, animated: true)
    }
    
    @objc func changeContainer(_ sender: UIButton){
        if sender.tag == 1 {
            changeButtonStatus(profileButton, true, 18)
            changeButtonStatus(soulRoutinButton, false, 18)
            profileContainerView.alpha = 1
            soulRoutinContainerView.alpha = 0
        } else {
            changeButtonStatus(profileButton, false, 18)
            changeButtonStatus(soulRoutinButton, true, 18)
            profileContainerView.alpha = 0
            soulRoutinContainerView.alpha = 1
        }
    }
}
