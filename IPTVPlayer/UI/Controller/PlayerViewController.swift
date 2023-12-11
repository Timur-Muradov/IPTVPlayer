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
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    private var player: AVPlayer!
    var channel: ChannelViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Cсылки в Json не работают. Взял рандомную ссылку с видео.
        let url = URL(string: "http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8")
        let asset = AVURLAsset(url: url!)
        let playerItem = AVPlayerItem(asset: asset)
        
        self.player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.insertSublayer(playerLayer, at: 0)
        player.play()
        
        player?.addObserver(self, forKeyPath: "status", options: [], context: nil)
        
        showLabel.textColor = UIColor(red: 143 / 255, green: 144 / 255, blue: 151 / 255, alpha: 1)
        
        channelNameLabel.textColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.8)
        
        showLabel.text = channel.currentShow
        channelNameLabel.text = channel.title
        
        if let imageUrl = channel?.logo {
            channelImageView.loadImageWithUrl(imageUrl)
        }
                
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let duration = self?.player.currentItem?.duration.seconds, duration.isFinite else { return }
            
            let progress = Float(time.seconds / duration)
            self?.videoProgress.setProgress(progress, animated: true)
        }
        
        for _ in asset.availableMediaCharacteristicsWithMediaSelectionOptions {
            if let group = asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.audible) {
                if let option = group.options.first {
                    playerItem.select(option, in: group)
                }
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let player = object as? AVPlayer, player == player, keyPath == "status" {
            if player.status == .readyToPlay {
                player.play()
            } else if player.status == .failed {
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
