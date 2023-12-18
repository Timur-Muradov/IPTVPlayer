//
//  PlayerViewController.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 06.12.2023.
//

import UIKit
import AVFoundation

/// Detailed view controller to show selected channel stream
class PlayerViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var interfaceView: UIView!
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
    // MARK: - Content model
    var channel: ChannelViewModel!
    // MARK: - Overrided properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    // MARK: - Private properties
    private var player: AVPlayer = AVPlayer()
    private var timer: Timer = Timer()
    private var videoResolution: VideoResolution = .auto {
        didSet {
            updateResolutionButtons(videoResolution)
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
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure player layer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.insertSublayer(playerLayer, at: 0)
        // Update video progress view
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1),
                                       queue: DispatchQueue.main) { [weak self] time in
            guard let duration = self?.player.currentItem?.duration.seconds, duration.isFinite else { return }
            let progress = Float(time.seconds / duration)
            self?.videoProgress.setProgress(progress, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        channelNameLabel.textColor = UIColor(red: 143 / 255, green: 144 / 255, blue: 151 / 255, alpha: 1)
        channelNameLabel.text = channel.title
        tvShowLabel.textColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        tvShowLabel.text = channel.currentShow
        changeResolutionStackView.alpha = 0.0
        changeResolutionStackView.spacing = 0.5
        if let imageUrl = channel?.logo {
            channelImageView.loadImageWithUrl(imageUrl)
        }
        videoResolution = .auto
    }
    // MARK: - Actions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func toggleSettingButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeResolutionStackView.alpha = self.changeResolutionStackView.alpha == 1.0 ? 0.0 : 1.0
        })
        updateResolutionButtons(self.videoResolution)
        resetTimer()
    }
    
    /// Change playback resolution
    @IBAction func toggleResolution(_ sender: ResolutionButton) {
        self.videoResolution = VideoResolution(rawValue: sender.tag) ?? .auto
    }
    
    @IBAction func toggleInterfaceView() {
        if interfaceView.alpha == 0.0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.interfaceView.alpha = 1.0
            })
            resetTimer()
        } else {
            hideInterfaceView()
        }
    }
}

// MARK: - Private extension
private extension PlayerViewController {
    func resetTimer() {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 4.0,
                                          target: self,
                                          selector: #selector(hideInterfaceView),
                                          userInfo: nil,
                                          repeats: false)
    }
    
    /// Make all buttons inactive exept active
    /// - Parameter active: button that should stay active
    func updateResolutionButtons(_ active: VideoResolution) {
        for button in resolutionButtons {
            button.makeActive(button.tag == active.rawValue ? true : false)
        }
    }
    
    @objc func hideInterfaceView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.changeResolutionStackView.alpha = 0.0
            self.interfaceView.alpha = 0.0
        })
    }
}

