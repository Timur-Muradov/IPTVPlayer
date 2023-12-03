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
    @IBOutlet weak var logoImageView: ImageViewWithLoader!
    @IBOutlet weak var favoriteButton: UIButton!
    weak var delegate: ChannelCellDelegate?
    var channel: ChannelViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        tvShowLabel.text = ""
        logoImageView.image = nil
        logoImageView.imageURL = nil
        favoriteButton.setImage(UIImage(imageLiteralResourceName: "starInactive"), for: .normal)
    }
    
    func updateUI() {
        titleLabel.text = channel?.title
        tvShowLabel.text = channel?.currentShow
        if let imageUrl = channel?.logo {
            logoImageView.loadImageWithUrl(imageUrl)
        }
        if let isFavorite = channel?.isFavorite,
           isFavorite == true {
            favoriteButton.setImage(UIImage(imageLiteralResourceName: "starActive"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(imageLiteralResourceName: "starInactive"), for: .normal)
        }
    }
    
    @IBAction func toggleFavorite(_ sender: Any) {
        guard let channel = channel else { return }
        delegate?.toggleFavorite(channel)
    }
}
