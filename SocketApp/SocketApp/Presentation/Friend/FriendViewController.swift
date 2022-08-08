//
//  FriendViewController.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import UIKit
import Kingfisher


class FriendViewController: UIViewController {

    // MARK: - Components
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let friendManager = FriendService.shared
    var friend: [FriendModel] = []
    var favorite: [FriendModel] = []
    var recommand: [FriendModel] = []
    
    let sectionArr: [String] = ["친구","즐겨찾기","추천친구"]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getData()
    }
    
    // MARK: - Functions
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
    }
    
    func getData() {
        friendManager.getFriendAPI { response in
            self.friend = response.data
            self.tableView.reloadData()
        }
        friendManager.getFavoriteAPI { response in
            self.favorite = response.data
            self.tableView.reloadData()
        }
        
        friendManager.getRecommendAPI { response in
            self.recommand = response.data
            self.tableView.reloadData()
        }
        
    }
    
}
