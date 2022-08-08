//
//  FriendCell.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import UIKit

class FirendCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.masksToBounds = true

    }
}
