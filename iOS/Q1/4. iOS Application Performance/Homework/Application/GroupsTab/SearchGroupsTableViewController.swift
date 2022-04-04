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
//    var searchGroups: [Groups] = []
    var searchGroups: [GroupsDAO] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
