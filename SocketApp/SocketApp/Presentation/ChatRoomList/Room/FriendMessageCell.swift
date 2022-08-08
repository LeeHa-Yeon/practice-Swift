//
//  FriendMessageCell.swift
//  SocketApp
//
//  Created by hayeon.lee on 2022/08/08.
//

import UIKit

class FriendMessageCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imgmessageImgView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
    }
}
