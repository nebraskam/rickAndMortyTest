//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 16-07-22.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func loadCharacters()
    func showDefaultError()
}

final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setupTableView()
        viewModel.loadCharacters()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        navigationItem.title = "Characters"
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersPreview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterCell else {
            return UITableViewCell()
        }
        let character = viewModel.charactersPreview[indexPath.row]
        cell.configure(model: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.navigateToCharacter(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row >= viewModel.charactersPreview.count - 2 else { return }
        viewModel.loadMoreCharacters()
    }
}

extension HomeViewController: HomeViewProtocol {
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func loadCharacters() {
        tableView.reloadData()
    }
    
    func showDefaultError() {
//        TODO: implement default error view
    }
}
