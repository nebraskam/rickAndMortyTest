//
//  DetailView.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
import UIKit
import Kingfisher

final class DetailView: UIView {
    
    private enum Constants {
        static let descriptionSpacing: CGFloat = 10
    }
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let descriptionContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private let statusComponentView: StatusComponentView = {
        let view = StatusComponentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lastLocationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Last known location:"
        return label
    }()
    
    private let lastLocationDescripionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let originLocationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "First seen in:"
        return label
    }()
    
    private let originLocationDesciptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(characterImageView)
        addSubview(descriptionContainerStackView)
        
        descriptionContainerStackView.addArrangedSubview(characterNameLabel)
        descriptionContainerStackView.addArrangedSubview(statusComponentView)
        
        descriptionContainerStackView.addArrangedSubview(lastLocationTitleLabel)
        descriptionContainerStackView.addArrangedSubview(lastLocationDescripionLabel)
        
        descriptionContainerStackView.addArrangedSubview(originLocationTitleLabel)
        descriptionContainerStackView.addArrangedSubview(originLocationDesciptionLabel)
        
        setupStyle()
        setupConstraints()
    }
    
    private func setupStyle() {
        descriptionContainerStackView.setCustomSpacing(5, after: lastLocationTitleLabel)
        descriptionContainerStackView.setCustomSpacing(5, after: originLocationTitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            
            descriptionContainerStackView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: Constants.descriptionSpacing),
            descriptionContainerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.descriptionSpacing),
            trailingAnchor.constraint(equalTo: descriptionContainerStackView.trailingAnchor, constant: Constants.descriptionSpacing),
            bottomAnchor.constraint(greaterThanOrEqualTo: descriptionContainerStackView.bottomAnchor),
                        
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor)
        ])
    }
    
    func configure(model: CharacterRepresentationModel) {
        characterNameLabel.text = model.name
        let url = URL(string: model.imageUrl)
        characterImageView.kf.setImage(with: url)
        
        let status = StatusModel(rawValue: model.status) ?? .unkown
        statusComponentView.configure(status: status, description: model.species)
        
        lastLocationDescripionLabel.text = model.lastLocation
        originLocationDesciptionLabel.text = model.originLocation
    }
}
