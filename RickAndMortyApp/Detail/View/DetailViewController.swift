//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView: DetailView = {
        let view = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let model: CharacterRepresentationModel
    
    init(model: CharacterRepresentationModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: detailView.bottomAnchor)
        ])
        detailView.configure(model: model)
        navigationItem.title = model.name
    }
    
    private func setupStyle() {
        view.backgroundColor = .systemBackground
    }
}
