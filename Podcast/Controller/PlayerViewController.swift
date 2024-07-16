//
//  PlayerViewController.swift
//  Podcast
//
//  Created by OmerErbalta on 14.07.2024.
//

import UIKit
import AVKit
class PlayerViewController:UIViewController{
    //MARK: - Properties
    var episode:Episode
    private var mainStackView:UIStackView!
    private lazy var closeButton:UIButton = {
        let button = UIButton(type: .system)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    private let episodeImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    private let sliderView:UISlider = {
       let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.tintColor = .darkGray
       
        return slider
    }()
    
    private var timerStackView:UIStackView!
    private let startLabel:UILabel = {
        let label = UILabel()
        label.text = "00 : 00"
        label.textAlignment = .left
        
        return label
    }()
    private let endLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "00 : 00"
        
        return label
    }()
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.text = "name"
        
        return label
    }()
    private let userLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "user"
        
        return label
    }()
    private var playStackView:UIStackView!
    private lazy var goForWardButton:UIButton = {
       let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "goforward.30"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleGoForWard), for: .touchUpInside)


        
        return button
    }()
    private lazy var goPlayButton:UIButton = {
       let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleGoPlayButton), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .darkGray
        
        return button
    }()
    private lazy var goBackrWardButton:UIButton = {
       let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleGobackWard), for: .touchUpInside)
        
        return button
    }()
    private var volumeStackView:UIStackView!
    private lazy var volumeSlideView:UISlider = {
       let slider = UISlider()
        slider.tintColor = .darkGray
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(handleVolumeSliderView), for: .valueChanged)
        return slider
    }()
    private let plusVolumeImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.wave.3.fill")
        imageView.tintColor = .lightGray

        return imageView
    }()
   
    private let minusVolumeImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.wave.1.fill")
        imageView.tintColor = .lightGray
        
        return imageView
    }()
    private let player:AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    //MARK: - Lifecycle
    init(episode:Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        style()
        layout()
        startPlayer()
        configureUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.pause()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Selectors
extension PlayerViewController{
    @objc private func handleVolumeSliderView(_ sender:UISlider){
        player.volume = sender.value
    }
    @objc private func handleGobackWard(_ sender:UIButton){
        updateForWard(value: -15)
    }
    @objc private func handleGoForWard(_ sender:UIButton){
        updateForWard(value: 30)

    }
    @objc private func handleGoPlayButton(_ sender:UIButton){
        if player.timeControlStatus == .paused {
            player.play()
            animateButtonImage(imageName: "pause.fill")
        } else {
            player.pause()
            animateButtonImage(imageName: "play.fill")
        }
    }
    @objc private func handleCloseButton(_ sender:UIButton){
        player.pause()
        self.dismiss(animated: true)
    }

    private func animateButtonImage(imageName: String) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.goPlayButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        self.goPlayButton.layer.add(transition, forKey: kCATransition)
        CATransaction.commit()
    }
}
//MARK: - Helpers
extension PlayerViewController{
    private func updateForWard(value:Int64){
        let exampleTime = CMTime(value: value, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), exampleTime)
        player.seek(to: seekTime)
    }
    fileprivate func updateSlider(){
        let currentTimeSecond = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let resultSecondTime = currentTimeSecond / durationTime
        self .sliderView.value = Float(resultSecondTime)
    }
    fileprivate func updateTimeLabel(){
        let intervel  = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: intervel, queue: .main) { time in
            self.startLabel.text = time.formatString()
            let endTimeSecond = self.player.currentItem?.duration
            self.endLabel.text = endTimeSecond?.formatString()
            self.updateSlider()
             
        }
    }
    private func playPlayer(url:URL){
        let playerItem = AVPlayerItem(url: url)
        player.play()
        self.goPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.volumeSlideView.value = 40
        updateTimeLabel()
        
    }
    private func startPlayer(){
        if episode.fileUrl != nil{
            guard let url  = URL(string: episode.fileUrl ?? "") else {return}
            guard var fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            fileUrl.append(path: url.lastPathComponent)
            playPlayer(url: fileUrl)
            return
        }
        guard let url = URL(string: episode.streamUrl) else{return}
        playPlayer(url: url)

    }
    
    private func style(){
        view.backgroundColor = .white
        
        timerStackView = UIStackView(arrangedSubviews: [startLabel,endLabel])
        timerStackView.axis = .horizontal
        
        let fullTimerStackView = UIStackView(arrangedSubviews:[ sliderView,timerStackView])
        fullTimerStackView.axis = .vertical
        
        playStackView = UIStackView(arrangedSubviews: [UIView(),goBackrWardButton,UIView(),goPlayButton,UIView(),goForWardButton,UIView()])
        playStackView.axis = .horizontal
        playStackView.distribution = .fillEqually
        
        volumeStackView = UIStackView(arrangedSubviews: [minusVolumeImageView,volumeSlideView,plusVolumeImageView])
        volumeStackView.axis = .horizontal
        
        mainStackView = UIStackView(arrangedSubviews: [closeButton,episodeImageView,fullTimerStackView,nameLabel,userLabel,UIView(),playStackView,volumeStackView])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        print(episode.title)
        
    }
    
    private func layout(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            episodeImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            sliderView.heightAnchor.constraint(equalToConstant: 40),
            
            playStackView.heightAnchor.constraint(equalToConstant: 50),
            
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            
        ])
    }
    private func configureUI(){
        self.episodeImageView.kf.setImage(with: URL(string: episode.imageUrl))
        self.nameLabel.text = episode.title
        self.userLabel.text = episode.author
    }

}

