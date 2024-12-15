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
        segmentControl.commaSeparatedButtonTitles = "all anime,update anime"
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func segmentChanged(_ sender: CustomSegmentControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            removeChildViewControllersWithAnimation()
        case 1:
            switchToViewControllerWithAnimation(AnimeFuncsScreenController())
        default:
            break
        }
    }

    private func switchToViewControllerWithAnimation(_ viewController: UIViewController) {

        removeChildViewControllersWithAnimation()
        
        addChild(viewController)
        
        viewController.view.frame = view.bounds
        viewController.view.alpha = 0.0
        view.addSubview(viewController.view)
        
        UIView.animate(withDuration: 0.2, animations: {
            viewController.view.alpha = 1.0
        }) { _ in
            viewController.didMove(toParent: self)
        }
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func removeChildViewControllersWithAnimation() {
        for child in children {
            child.willMove(toParent: nil)
            
            UIView.animate(withDuration: 0.2, animations: {
                child.view.alpha = 0.0
            }) { _ in
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
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
