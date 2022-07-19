//
//  StatusComponentView.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
import UIKit

final class StatusComponentView: UIView {
    
    private enum Constants {
        static let bulletSize: CGFloat = 15
    }
    
    private let statusBullet: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(statusBullet)
        containerStackView.addArrangedSubview(statusDescriptionLabel)
        setupStyle()
        setupConstraints()
    }
    
    private func setupStyle() {
        statusBullet.layer.cornerRadius = Constants.bulletSize / 2
        statusBullet.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: containerStackView.trailingAnchor),
            bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor),
            
            statusBullet.heightAnchor.constraint(equalToConstant: Constants.bulletSize),
            statusBullet.widthAnchor.constraint(equalToConstant: Constants.bulletSize)
        ])
    }
    
    func configure(status: StatusModel, description: String) {
        let color = getStatusColor(with: status)
        statusBullet.backgroundColor = color
        statusDescriptionLabel.text = "\(status.rawValue) - \(description)"
    }
    
    private func getStatusColor(with status: StatusModel) -> UIColor {
        switch status {
        case .alive:
            return .green
        case .unkown:
            return .gray
        case .dead:
            return .red
        }
    }
}
