//
//  SearchCell.swift
//  Podcast
//
//  Created by OmerErbalta on 28.06.2024.
//

import Foundation
import UIKit
class SearchCell:UITableViewCell{
    
    //MARK: - Properties
    private var photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    private let trackName:UILabel = {
        let Label = UILabel()
        Label.text = "trackName"
        Label.font = .boldSystemFont(ofSize: 18)
        return Label
    }()
    private let artistName:UILabel = {
        let label = UILabel()
        label.text = "artistName"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 16)

        return label
    }()
    private let trackCount:UILabel = {
        let Label = UILabel()
        Label.text = "trackCount"
        Label.textColor = .lightGray
        Label.font = .boldSystemFont(ofSize: 14)

        return Label
    }()
    private var stackView :UIStackView!
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helpers
extension SearchCell{
    private func setup(){
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 16
        stackView = UIStackView(arrangedSubviews: [trackName,artistName,trackCount])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    private func layout(){
        addSubview(photoImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            
            stackView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor,constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 8)
            
            
            ])
    }
}
