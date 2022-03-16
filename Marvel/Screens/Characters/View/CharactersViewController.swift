//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Monika Saini on 10/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
 
    @IBOutlet var tableView: UITableView!

    lazy var viewModel = {
        CharactersViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }

    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true

        tableView.register(CharacterCell.nib, forCellReuseIdentifier: CharacterCell.identifier)
    }

    func initViewModel() {
        // Get characters data
        viewModel.getCharacters()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "characterDetailVC") as! CharacterDetailViewController
        // #2 - The ViewModel is the app's de facto data source.
        // The ViewModel data for the currently-selected table
        // view cell representing a Messier object is passed to
        // a detail view controller via a segue.
        destinationViewController.characterCellViewModel = viewModel.getCellViewModel(at: indexPath)
        self.navigationController?.show(destinationViewController, sender: nil)
    }
}

// MARK: - UITableViewDataSource

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
