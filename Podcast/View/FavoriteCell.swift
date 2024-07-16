//
//  FavoriteCell.swift
//  Podcast
//
//  Created by OmerErbalta on 15.07.2024.
//

import Foundation
import UIKit
class FavoriteCell:UICollectionViewCell{
    //MARK: - Properties
    var podcastCoreData:PodcastCoreData?{
        didSet{
            configure()
        }
    }
    private let podcastImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        
        return imageView
    }()
    
    private let podcastNameLabel:UILabel = {
        let label = UILabel()
        label.text = "Podcast Name"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let podcastArtistNameLabel:UILabel = {
        let label = UILabel()
        label.text = "Podcast Artist Name"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    private var fullStackView:UIStackView!
    //MARK: -Lifecycle
    override init(frame:CGRect){
        super.init(frame:frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helpers
extension FavoriteCell{
    private func style(){
        fullStackView = UIStackView(arrangedSubviews: [podcastImageView,podcastNameLabel,podcastArtistNameLabel])
        fullStackView.axis = .vertical
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        addSubview(fullStackView)
        NSLayoutConstraint.activate([
            
            podcastImageView.heightAnchor.constraint(equalTo: podcastImageView.widthAnchor),
            
            fullStackView.topAnchor.constraint(equalTo: topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    private func configure(){
        guard let podcastCoreData = self.podcastCoreData else {return}
        let viewModel = FavoriteCellViewModel(podcastCoreData: podcastCoreData)
        self.podcastImageView.kf.setImage(with: viewModel.podcastImageUrl)
        self.podcastNameLabel.text = viewModel.podcastName
        self.podcastArtistNameLabel.text = viewModel.podcastArtistName
    }
}
