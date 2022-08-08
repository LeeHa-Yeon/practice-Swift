//
//  FriendViewController + TableView.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import UIKit

extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Section
    // section 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    
    // section 이름
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArr[section]
    }
    
    // section 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // section 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.tintColor = UIColor(red: 91, green: 71, blue: 244, alpha: 0)
        // header.textLabel?.frame = header.frame
        // header.textLabel?.textAlignment = .center
    }
    
    
    // MARK: - Row
    // 각 section에서의 row 개수
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
    
    // row 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // row cell 설정
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
    
}
