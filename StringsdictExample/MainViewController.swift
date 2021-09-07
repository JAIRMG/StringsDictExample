//
//  ViewController.swift
//  StringsdictExample
//
//  Created by Jair Moreno Gaspar on 02/09/21.
//

import UIKit

class MainViewController: UITableViewController {

    private var magicTowns = ["San Cristóbal de Las Casas", "Bacalar", "Orizaba", "Mitla",
                          "Tequila", "Bernal", "Cuetzalan", "Cuatro Ciénegas", "Huachinango", "Taxco", "Cholula", "Jerez", "Huasca de Ocampo"]
    private var selectedTowns = Set<String>()
    
    private lazy var selectAllBarButtonItem = UIBarButtonItem(title: NSLocalizedString("MAIN_NAV_SELECT_ALL", comment: ""), style: .plain, target: self, action: #selector(didTapSelectAll))
    
    private lazy var textToolbarItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .lightGray
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Magic towns"
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsSelectionDuringEditing = true
        setupBarsForNormalState()
        setupInitialToolbarState()
    }

}

// MARK: - Private methods
extension MainViewController {
    private func updateViewForEditing(isEditing: Bool) {
        if isEditing {
            setupBarsForEditing()
        } else {
            setupBarsForNormalState()
        }
    }
    
    private func setupBarsForEditing() {
        navigationItem.setRightBarButton(selectAllBarButtonItem, animated: true)
        toolbarItems?.removeAll()
        navigationController?.isToolbarHidden = false
        let items = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapTrash)),
            .emptyBarButton,
            .emptyBarButton
        ]
        toolbarItems = items
    }
    
    private func setupBarsForNormalState() {
        navigationItem.setLeftBarButton(editButtonItem, animated: true)
        toolbarItems?.removeAll()
        selectedTowns.removeAll()
        navigationItem.rightBarButtonItem = nil
        navigationController?.isToolbarHidden = true
        let items = [
            .emptyBarButton,
            textToolbarItem,
            .emptyBarButton
        ]
        toolbarItems = items
    }
    
    private func setupInitialToolbarState() {
        navigationController?.isToolbarHidden = true
        
        let items = [
            .emptyBarButton,
            textToolbarItem,
            .emptyBarButton
        ]
        toolbarItems = items
    }
    
    private func deleteTowns(_ towns: Set<String>) {
        print("implement logic to remove towns")
    }
}

// MARK: - Objc methods
extension MainViewController {
    @objc private func didTapSelectAll() {
        tableView.allIndexPaths.forEach {
            tableView.selectRow(at: $0, animated: true, scrollPosition: .none)
            tableView.delegate?.tableView?(tableView, didSelectRowAt: $0)
        }
    }
    
    @objc private func didTapTrash() {
        var title = ""
        
        if selectedTowns.isEmpty {
            title = NSLocalizedString("EMPTY_TOWNS_SELECTION", comment: "")
        } else if selectedTowns.count == 1 {
            title = NSLocalizedString("ONE_TOWN_SELECTION", comment: "")
        } else {
            title = String(format: NSLocalizedString("MULTIPLE_TOWNS_SELECTION", comment: ""), selectedTowns.count)
        }
        
        showAlertSheet(title: title) { [weak self] in
            guard let self = self else { return }
            self.deleteTowns(self.selectedTowns)
        }
    }
}

// MARK: - Editing mode
extension MainViewController {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        selectedTowns.removeAll()
        updateViewForEditing(isEditing: editing)
    }
}

// MARK: - Table data source methods
extension MainViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = magicTowns[indexPath.row]
        return cell
    }
}

// MARK: - Table view delegate methods
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        magicTowns.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTown = magicTowns[indexPath.row]
        selectedTowns.insert(selectedTown)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedTown = magicTowns[indexPath.row]
        selectedTowns.remove(selectedTown)
    }
}
