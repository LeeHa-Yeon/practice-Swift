//
//  CelebrityRoutinViewController.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/12.
//

import UIKit
import Then
import SnapKit

class CelebrityRoutinViewController: UIViewController {
    
    var routinDic: [String:String] = ["06:00":"기상","06:30":"일하기","07:30":"가족과 함께 아침 식사","09:00":"사무실 도착","09:30":"오전 미팅","12:00":"점심 식사","13:30":"Design Lab 방문","15:30":"이메일, 미팅, 전화 업무","17:30":"가족과 함께 저녁 식사","18:30":"소중한 사람과 시간 보내기","22:00":"음악 감상, 명상 및 기도"]
    
    //MARK: - UI Components
    
    lazy var tableView = UITableView().then {
        $0.register(CelebrityRoutinCell.self, forCellReuseIdentifier: CelebrityRoutinCell.identifier)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding = 0
    }
    
    var spaceView = UIView().then {
        $0.backgroundColor = .clear
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
        [tableView,spaceView].forEach{ view.addSubview($0) }
        
        tableView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        spaceView.snp.makeConstraints{
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
    }
    
    
    func setUI(){
        self.view.backgroundColor = .white
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: - objc Functions
    
}

extension CelebrityRoutinViewController: UITableViewDelegate, UITableViewDataSource {
    
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


class CelebrityRoutinCell : UITableViewCell {
    static let identifier: String = "celebrityRoutinCell"
    
    lazy var circleImageView = UIImageView().then {
        $0.image = UIImage(named: "circle")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var timeLabel = UILabel().then {
        $0.textColor = UIColor(named: "soulGray1")
        $0.font = UIFont(name: "Pretendard-Regular", size: 12.0)
    }
    
    lazy var scheduleLabel = UILabel().then {
        $0.textColor = UIColor(named: "soulBlack")
        $0.font = UIFont(name: "Pretendard-Regular", size: 16.0)
    }
    
    lazy var checkImageView = UIImageView().then {
        $0.image = UIImage(named: "icon_check")
        $0.isHidden = true
        $0.contentMode = .scaleAspectFit
    }
    
    // 계속 바뀜
    // 뷰를 추가하거나, 사이즈 바꾸거나, 레이블 넣거나 지우는 과정 ->> 레이아웃 정의
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // 재사용할 때 사용
    override func awakeFromNib() {
        super.awakeFromNib()
        //        self.layoutSubviews()
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    func setLayout(){
        [circleImageView,timeLabel,scheduleLabel,checkImageView].forEach{ contentView.addSubview($0) }
        
        circleImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(17)
            $0.width.height.equalTo(8)
        }
        timeLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(circleImageView.snp.trailing).offset(8)
        }
        scheduleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(timeLabel.snp.trailing).offset(24)
        }
        
        checkImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(22)
        }
    }
    
    func setUI(){
        self.contentView.backgroundColor = UIColor(named: "soulPink2")
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    
}
