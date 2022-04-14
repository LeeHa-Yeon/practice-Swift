//
//  TodoViewController.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/12.
//

import UIKit
import SnapKit
import Then

class TodoViewController: UIViewController {
    
    var routinDic: [String:String] = ["06:00":"기상","06:30":"일하기","07:30":"가족과 함께 아침 식사","09:00":"사무실 도착","09:30":"오전 미팅","12:00":"점심 식사","13:30":"Design Lab 방문","15:30":"이메일, 미팅, 전화 업무","17:30":"가족과 함께 저녁 식사","18:30":"소중한 사람과 시간 보내기","22:00":"음악 감상, 명상 및 기도"]
    
    //MARK: - UI Components
    
    lazy var titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(celebrityNameLabel)
        $0.addArrangedSubview(middleLabel)
        $0.addArrangedSubview(leftCntLabel)
        $0.addArrangedSubview(lastLabel)
    }
    
    lazy var celebrityNameLabel = UILabel().then {
        $0.text = "스티브 잡스"
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.textColor = .white
    }
    
    lazy var middleLabel = UILabel().then {
        $0.text = "를 따라잡기까지 "
        $0.font = UIFont(name: "Pretendard-Regular", size: 18)
        $0.textColor = .white
    }
    
    lazy var leftCntLabel = UILabel().then {
        $0.text = "n항목"
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.textColor = .white
    }
    
    lazy var lastLabel = UILabel().then {
        $0.text = " 남았어요!"
        $0.font = UIFont(name: "Pretendard-Regular", size: 18)
        $0.textColor = .white
    }
    
    lazy var dateLabel = UILabel().then {
        $0.text = "2022/03/31"
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.textColor = .white
    }
    
    lazy var progressView = UIProgressView().then {
        $0.trackTintColor = .clear
        $0.progressTintColor = .white
        $0.progress = 0.7
        $0.clipsToBounds = true
    }
    
    lazy var bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    lazy var subTitleLabel = UILabel().then {
        $0.text = "스티브 잡스의 소울 루틴 따라잡기"
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.textColor = UIColor(named: "soulBlack")
    }
    
    var tableView = UITableView().then {
        $0.register(CelebrityRoutinCell.self, forCellReuseIdentifier: CelebrityRoutinCell.identifier)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding = 0
    }
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setUI()
        setTableView()
    }
    
    //MARK: - Functions
    func setLayout(){
        [subTitleLabel,tableView].forEach{ bottomSheetView.addSubview($0)}
        
        [titleStackView,dateLabel,progressView,bottomSheetView].forEach{ view.addSubview($0) }
        
        titleStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        progressView.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(15)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(17)
            $0.trailing.equalToSuperview().inset(68)
            $0.height.equalTo(10)
        }
        
        bottomSheetView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(progressView.snp.bottom).offset(45)
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(48)
            $0.leading.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(6)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    
    }
    
    func setUI(){
        self.view.backgroundColor = UIColor(named: "soulMain")
        setProgress()
    }
    
    func setProgress(){
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.white.cgColor
        progressView.layer.cornerRadius = 5
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    //MARK: - objc Functions
    
}


extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return routinDic.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CelebrityRoutinCell.identifier, for: indexPath) as? CelebrityRoutinCell else {
            return UITableViewCell()
        }
        let sortedRoutinList = routinDic.sorted{ $0.0 < $1.0 }
        cell.timeLabel.text = sortedRoutinList[indexPath.section].key
        cell.scheduleLabel.text = sortedRoutinList[indexPath.section].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // 테이블뷰 section header 고정 해제
    public func scrollViewDidScroll(_ scrollView: UIScrollView){
        let scrollHeaderHeight = tableView.rowHeight
        
        if scrollView.contentOffset.y <= scrollHeaderHeight{
            if scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
            }
        } else if (scrollView.contentOffset.y >= scrollHeaderHeight){
            scrollView.contentInset = UIEdgeInsets(top: -scrollHeaderHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
}
