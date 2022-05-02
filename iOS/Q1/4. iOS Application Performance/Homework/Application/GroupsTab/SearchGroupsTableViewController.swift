//
//  SearchGroupsTableViewController.swift
//  Homework
//
//  Created by Пользователь on 05.01.2022.
//

import UIKit
import SDWebImage

class SearchGroupsTableViewController: UITableViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var groupsAPI = GroupsAPI()
    var searchGroups: [GroupsDAO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchGroupCell", for: indexPath) as! SearchGroupsTableViewCell
    
        let searchGroup = searchGroups[indexPath.row]
        cell.searchGroupName.text = searchGroup.name
        if let url = URL(string: searchGroup.photo50) {
            cell.searchGroupAvatar?.sd_setImage(with: url, completed: nil)
        }

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard searchText != "" else { return }
        // получаем список искомых групп
        groupsAPI.searchGroups(searchText: searchText) {  [weak self] searchGroups in
            guard let self = self else { return }
            self.searchGroups = searchGroups
            self.tableView.reloadData()
        }
    }

}
