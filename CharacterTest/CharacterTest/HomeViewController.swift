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
    
    let viewModel = HomeViewModel()
    
    //MARK: - UI Components
    lazy var myRoutinBarButton = UIBarButtonItem().then{
        $0.image = UIImage(named:"icon_profile")
        $0.style = .plain
        $0.tintColor = UIColor(named: "soulMain")
        $0.target = self
        $0.action = #selector(moveToVC2(sender:))
    }
    
    lazy var topView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
        $0.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner ]
        $0.clipsToBounds = true
    }
    
    lazy var dateLabel = UILabel().then {
        $0.text = getFormattedDate()
        $0.font = UIFont(name: "Pretendard-Regular", size: 14.0)
        $0.textColor = UIColor(named: "soulGray1")
    }
    
    lazy var greetingsLabel = UILabel().then {
        $0.text = "안녕하세요~~"
        $0.font = UIFont(name: "Pretendard-Regular", size: 18.0)
        $0.textColor = UIColor(named: "soulBlack")
    }
    
    lazy var informationLabel = UILabel().then {
        $0.text = "오늘 체험할 셀럽을 선택해보세요!"
        $0.font = UIFont(name: "Pretendard-Bold", size: 24.0)
        $0.textColor = UIColor(named: "soulBlack")
    }
    
    private let layout = UICollectionViewFlowLayout().then{
        $0.minimumLineSpacing = 10 // 위아래 간격 최소값
        $0.minimumInteritemSpacing = 10 // 좌우 간격 최소값
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.register(TestCollectionCell.self, forCellWithReuseIdentifier: TestCollectionCell.identifier)
    }
    
    lazy var bottomView = UIView().then {
        $0.backgroundColor = UIColor(named: "soulSub")
        $0.layer.cornerRadius = 5
    }
    
    lazy var bottomMainLabel = UILabel().then {
        $0.text = "나와 어울리는 셀럽 알아보기"
        $0.font = UIFont(name: "Pretendard-Bold", size: 18.0)
        $0.textColor = UIColor(named: "soulBlack")
    }
    
    lazy var bottomSubLabel = UILabel().then {
        $0.text = "열심히 준비 중이에요:)"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14.0)
        $0.textColor = UIColor(named: "soulMain")
    }
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setUI()
        setData()
        setCollectionView()
        setBind()
    }
    
    //MARK: - Functions
    
    func setLayout(){
        [topView,collectionView, bottomView].forEach{ self.view.addSubview($0)}
        [dateLabel, greetingsLabel, informationLabel].forEach { topView.addSubview($0) }
        [bottomMainLabel, bottomSubLabel].forEach{ bottomView.addSubview($0)}
        
        topView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        greetingsLabel.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview().inset(20)
        }
        
        informationLabel.snp.makeConstraints{
            $0.top.equalTo(greetingsLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(33)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(bottomView.snp.top).offset(49)
        }
        
        bottomView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(73)
            $0.height.equalTo(100)
        }
        
        bottomMainLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(16)
        }
        
        bottomSubLabel.snp.makeConstraints{
            $0.top.equalTo(bottomMainLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
    }
    
    func setData(){
        viewModel.requestCelebrityList()
    }
    
    func setBind(){
        viewModel.celebrityList.bind { _ in
            self.collectionView.reloadData()
        }
    }
    
    func setUI(){
        self.view.backgroundColor = .white
        setNavigation()
        shadowView()
    }
    
    func shadowView(){
        topView.layer.masksToBounds = false
        topView.layer.shadowOffset = CGSize(width: 0, height: 10)
        topView.layer.shadowRadius = 8
        topView.layer.shadowOpacity = 0.6
        topView.layer.shadowColor = UIColor(named: "soulBlue")?.cgColor
    }
    
    func setNavigation(){
        navigationItem.rightBarButtonItem = myRoutinBarButton
    }
    
    func setCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getFormattedDate() -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM yyyy"
        return dateFormatterPrint.string(from: Date())
    }
    
    func urlToImg(urlStr: String, img: UIImageView){
        if let url: URL = URL(string: urlStr ){
            img.kf.indicatorType = .activity
            img.kf.setImage(with:url)
        }
    }
    
    func moveToVC(celebrityId: Int){
        let CharacterVC = CharacterViewController()
        CharacterVC.viewModel.celebrityId = celebrityId
        self.navigationController?.pushViewController(CharacterVC, animated: true)
    }
    
    //MARK: - objc Functions
    @objc func moveToVC2(sender: UIBarButtonItem){
        viewModel.requestLoadMyRoutin { response in
            if response {
                let TodoVC = TodoViewController()
                self.navigationController?.pushViewController(TodoVC, animated: true)
            }else {
                let popupView = AlertView(frame: self.view.bounds)
                popupView.popupAlert(iconStyle: .exclamationIcon, title: "아직 체험할 셀럽을 정하지 않았어요!", message: "홈 화면에서 오늘 체험하고 싶은 셀럽을 선택해주세요. ", firstBtnTitle: "확인", secondBtnTitle: nil, myView: popupView)
                popupView.parentMainView.backgroundColor = .white
                
                popupView.cancelButton.backgroundColor = UIColor(named: "soulMain")
                popupView.cancelButton.setTitleColor(.white, for: .normal)
                
                popupView.okButton.isHidden = true
                popupView.delegate = self
                self.view.addSubview(popupView)
            }
        }
        
    }
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.celebrityCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? TestCollectionCell else {
            return UICollectionViewCell()
        }
        let target = viewModel.getCelebrityData(idx: indexPath.row)
        urlToImg(urlStr: target.image, img: cell.celebrityImageView)
        cell.koreaNameLabel.text = target.name
        cell.englishNameLabel.text = target.englishName
        cell.countryLabel.text = target.nationality
        cell.hashTagView.backgroundColor = UIColor(named: "\(target.job.backgroundColor)")
        cell.careerLabel.text = target.job.name
        cell.careerLabel.textColor = UIColor(named: "\(target.job.textColor)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let target = viewModel.getCelebrityData(idx: indexPath.row)
        moveToVC(celebrityId: target.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 25
        let width: CGFloat = (self.view.frame.width-(2*margin))/2
        let height: CGFloat = width*188/170
        return CGSize(width: width, height: height)
    }
    
}

class TestCollectionCell: UICollectionViewCell {
    static let identifier: String = "collectionCell"
    
    lazy var celebrityImageView = UIImageView().then {
        $0.image = UIImage(named: "Mask group")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var koreaNameLabel = UILabel().then {
        $0.text = "스티브 잡스"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Bold", size: 16.0)
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
        $0.text = "Steve Jobs"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    
    lazy var separaterView = UIView().then{
        $0.backgroundColor = .white
    }
    
    lazy var countryLabel = UILabel().then {
        $0.text = "미국"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    lazy var hashTagView = UIView().then {
        $0.backgroundColor = UIColor(named:"soulRed1")
        $0.addSubview(careerLabel)
        $0.layer.cornerRadius = 4
    }
    lazy var careerLabel = UILabel().then {
        $0.text = "방송인"
        $0.textColor = UIColor(named: "soulNegative")
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setLayout(){
        [celebrityImageView,koreaNameLabel,subSmallStackView,hashTagView].forEach{ contentView.addSubview($0) }
        
        celebrityImageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(36)
        }
        
        koreaNameLabel.snp.makeConstraints{
            $0.top.equalTo(celebrityImageView.snp.bottom).offset(38)
            $0.leading.equalToSuperview().inset(16)
        }
        
        subSmallStackView.snp.makeConstraints{
            $0.top.equalTo(koreaNameLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(16)
        }
        
        separaterView.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        
        hashTagView.snp.makeConstraints{
            $0.top.equalTo(subSmallStackView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(36)
            $0.height.equalTo(18)
        }
        
        careerLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func setUI(){
        self.contentView.backgroundColor = UIColor(named: "soulMain")
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    
}



extension HomeViewController: CustomAlertProtocol {
    
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
}
