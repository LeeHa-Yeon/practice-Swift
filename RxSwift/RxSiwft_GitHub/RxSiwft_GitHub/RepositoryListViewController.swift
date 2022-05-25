//
//  RepositoryListViewController.swift
//  RxSiwft_GitHub
//
//  Created by 이하연 on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryListViewController: UITableViewController {
    private let organization = "Apple"
    
    // private let repositories = [Repository] 이전까지는 이렇게 시퀀스를 생성
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repositories"
        self.refreshControl = UIRefreshControl()
        let refreschControl = self.refreshControl!
        refreschControl.backgroundColor = .white
        refreschControl.tintColor = .darkGray
        refreschControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreschControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: RepositoryListCell.identifier)
        tableView.rowHeight = 140
    }
    
    func setLayout(){
        
    }
    
    func setTableView(){
    }
    
    @objc func refresh(){
        
    }
}

extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryListCell.identifier, for: indexPath) as? RepositoryListCell else { return UITableViewCell() }
        return cell
    }
}
