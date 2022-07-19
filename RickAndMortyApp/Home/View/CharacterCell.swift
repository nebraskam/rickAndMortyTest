//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 16-07-22.
//

import UIKit
import Kingfisher

final class CharacterCell: UITableViewCell {
    
    private enum Constants {
        static let containerSpacing: CGFloat = 20
        static let containerBottomSpacing: CGFloat = 5
        static let imageHeight: CGFloat = 300
        static let titleSpacing: CGFloat = 10
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(characterNameLabel)
        setupStyle()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.containerSpacing),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.containerSpacing),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerSpacing),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.containerBottomSpacing),
            
            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: Constants.titleSpacing),
            characterNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.titleSpacing),
            containerView.trailingAnchor.constraint(equalTo: characterNameLabel.trailingAnchor, constant: Constants.titleSpacing),
            containerView.bottomAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: Constants.titleSpacing)
        ])
    }
    
    private func setupStyle() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.systemGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowRadius = 12
        contentView.layer.shadowOpacity = 0.7
               
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        selectionStyle = .none
    }
    
    func configure(model: CharacterRepresentationPreviewModel) {
        let url = URL(string: model.imageUrl)
        characterImageView.kf.setImage(with: url)
        characterNameLabel.text = model.name
    }
}
