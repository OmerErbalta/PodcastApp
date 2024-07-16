//
//  EpisodeCell.swift
//  Podcast
//
//  Created by OmerErbalta on 9.07.2024.
//

import Foundation
import UIKit

class EpisodeCell: UITableViewCell {
    // MARK: - Properties
    var episode:Episode?{
        didSet{
            configure()
        }
    }
    var progressView:UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .lightGray
        progressView.tintColor = .systemPurple
        progressView.setProgress(Float(0), animated: true)
        progressView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        progressView.layer.cornerRadius = 12
        progressView.isHidden = true
        return progressView
        
    }()
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .purple
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    private let pubDateLabel:UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "pubDateLabel"
        return label
    }()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.text = "titleLabel"
        return label
    }()
    private let decriptionLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.text = "decriptionLabel "
        label.numberOfLines = 2
        return label
    }()
    private var stackView:UIStackView!
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension EpisodeCell {
    private func setup() {
        configureUI()
    }
    
    private func configureUI() {
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(episodeImageView)
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            episodeImageView.heightAnchor.constraint(equalToConstant: 100),
            episodeImageView.widthAnchor.constraint(equalToConstant: 100),
            episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            episodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            progressView.heightAnchor.constraint(equalToConstant: 20),
            progressView.leadingAnchor.constraint(equalTo: episodeImageView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: episodeImageView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: episodeImageView.bottomAnchor)
        ])
        stackView = UIStackView(arrangedSubviews: [pubDateLabel,titleLabel,decriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10)
        ])
    }
    private func configure(){
        guard let episode = self.episode else{return}
        self.titleLabel.text = episode.title
        let viewModel = EpisodeCellViewModel(episode: episode)
        self.episodeImageView.kf.setImage(with: viewModel.profileImageUrl)
        self.titleLabel.text = viewModel.title
        self.decriptionLabel.text = viewModel.description
        self.pubDateLabel.text = viewModel.pubDate
    }

}
