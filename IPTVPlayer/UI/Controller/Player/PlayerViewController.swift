//
//  PlayerViewController.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 06.12.2023.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var videoProgress: UIProgressView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var videoTimeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var channelImageView: ImageViewWithLoader!
    @IBOutlet weak var tvShowLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var changeResolutionStackView: UIStackView!
    @IBOutlet var resolutionButtons: [ResolutionButton]!
    private var videoResolution: VideoResolution = .auto {
        didSet {
            updateQualityButtons(videoResolution)
            switch videoResolution {
            case .auto:
                let item = channel.defaultItem.item
                player.replaceCurrentItem(with: item)
            default:
                let models = channel.availableItems.filter({ $0.resolution == videoResolution })
                if let model = models.first {
                    player.replaceCurrentItem(with: model.item)
                }
            }
            player.play()
        }
    }
    
    private var player: AVPlayer = AVPlayer()
    var channel: ChannelViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.insertSublayer(playerLayer, at: 0)
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let duration = self?.player.currentItem?.duration.seconds, duration.isFinite else { return }
            
            let progress = Float(time.seconds / duration)
            self?.videoProgress.setProgress(progress, animated: true)
        }
        
        changeResolutionStackView.spacing = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tvShowLabel.textColor = UIColor(red: 143 / 255, green: 144 / 255, blue: 151 / 255, alpha: 1)
        
        channelNameLabel.textColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.8)
        
        tvShowLabel.text = channel.currentShow
        channelNameLabel.text = channel.title
        changeResolutionStackView.isHidden = true
        
        if let imageUrl = channel?.logo {
            channelImageView.loadImageWithUrl(imageUrl)
        }
        videoResolution = .auto
    }
        
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func settingButton(_ sender: UIButton) {
        changeResolutionStackView.isHidden = !changeResolutionStackView.isHidden
        updateQualityButtons(self.videoResolution)
    }
    
    @IBAction func toggleQuality(_ sender: ResolutionButton) {
        self.videoResolution = VideoResolution(rawValue: sender.tag) ?? .auto
    }
    
    private func updateQualityButtons(_ active: VideoResolution) {
        for button in resolutionButtons {
            button.makeActive(button.tag == active.rawValue ? true : false)
        }
    }
}
