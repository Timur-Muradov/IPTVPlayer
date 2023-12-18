//
//  ChannelTableViewCell.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import UIKit

/// Channel table view cell
final class ChannelTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tvShowLabel: UILabel!
    @IBOutlet weak var logoImageView: ImageViewWithLoader!
    @IBOutlet weak var favoriteButton: UIButton!
    // MARK: - Properties
    weak var delegate: ChannelCellDelegate?
    var channel: ChannelViewModel? {
        didSet {
            updateUI()
        }
    }
    // MARK: - Cell life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
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
    // MARK: - Actions
    @IBAction func toggleFavorite(_ sender: Any) {
        guard let channel = channel else { return }
        delegate?.toggleFavorite(channel)
    }
}
