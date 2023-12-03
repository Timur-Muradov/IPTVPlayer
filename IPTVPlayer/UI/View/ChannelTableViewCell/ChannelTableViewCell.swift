//
//  ChannelTableViewCell.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import UIKit

final class ChannelTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tvShowLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
