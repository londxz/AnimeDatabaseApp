//
//  DataBaseAnimeScreen.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 09.12.2024.
//

import UIKit

class DataBaseAnimeController: UIViewController {
    
    private let build = DatabaseAnimeView.shared
    
    //viewModels
    var animeViewModel = AnimeViewModel()
    var segmentControl = CustomSegmentControl()
    var tableView = UITableView()
    
    
    var cellDataSource: [AnimeCellViewModel] = []
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5
        
        setSegmentControl()
        setTableView()
        
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animeViewModel.getData()
    }
    
    private func setSegmentControl() {
        segmentControl = build.segmentControl
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setTableView() {
        tableView = build.tableView
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        configTableView()
        
    }
    
    private func bindViewModel() {
        
        animeViewModel.cellDataSource.bind { [weak self] anime in
            guard let self = self, let anime = anime else {
                return
            }
            DispatchQueue.main.async {
                self.cellDataSource = anime
                self.reloadTableView()
            }
        }
    }
    
    func openDetail(animeId: Int) {
        print("Opening details for animeId: \(animeId)")
        guard let anime = animeViewModel.injectAnime(with: animeId) else {
            print("error in openDetail")
            return
        }
        
        let detailsViewModel = DetailsAnimeViewModel(anime: anime)
        let detailsController = DetailsAnimeController(viewModel: detailsViewModel)
        
        detailsController.modalPresentationStyle = .fullScreen
        present(detailsController, animated: true)
    }
}
