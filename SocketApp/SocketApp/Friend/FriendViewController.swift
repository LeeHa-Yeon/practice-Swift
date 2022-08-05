//
//  FriendViewController.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/04.
//

import UIKit
import Kingfisher


class FriendViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let friendManager = FriendService.shared
    var friend: [FriendModel] = []
    var favorite: [FriendModel] = []
    var recommand: [FriendModel] = []
    
    let sectionArr: [String] = ["친구","즐겨찾기","추천친구"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getData()
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
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

extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArr[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 80
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return ""
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return friend.count
        case 1:
            return favorite.count
        case 2:
            return recommand.count
        default:
            assert(false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "firendCell", for: indexPath) as? FirendCell else {
            return UITableViewCell()
        }
       
        switch indexPath.section {
        case 0:
            cell.nameLabel.text = friend[indexPath.row].name
            let url: URL = URL(string: friend[indexPath.row].profile)!
            cell.profileImg.kf.setImage(with: url)
            return cell
            
        case 1:
            cell.nameLabel.text = favorite[indexPath.row].name
            let url: URL = URL(string: favorite[indexPath.row].profile)!
            cell.profileImg.kf.setImage(with: url)
            return cell
        case 2:
            cell.nameLabel.text = recommand[indexPath.row].name
            let url: URL = URL(string: recommand[indexPath.row].profile)!
            cell.profileImg.kf.setImage(with: url)
            return cell
        default :
            assert(false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.textColor = UIColor.black
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//            header.textLabel?.frame = header.frame
//            header.textLabel?.textAlignment = .center
        view.tintColor = UIColor.yellow
        
        }
    
//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        view.tintColor = UIColor.systemPink
//    }
    
    
}

class FirendCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.masksToBounds = true
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
    }
}
