//
//  FriendsTableViewController.swift
//  Homework
//
//  Created by Пользователь on 08.02.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var avatars: [UIImage] = [
        UIImage(named: "BartolomeoDAlviano.png")!,
        UIImage(named: "KaterinaSforza.png")!,
        UIImage(named: "LaVolpe.png")!,
        UIImage(named: "Leonardo.png")!,
        UIImage(named: "LorenzoMedici.png")!,
        UIImage(named: "Mario.png")!,
        UIImage(named: "Paula.png")!,
        UIImage(named: "Rosa.png")!,
        UIImage(named: "Teodora.png")!
    ]
    
    var friends = [
        "Bartolomeo D'Alviano",
        "Katerina Sforza",
        "La Volpe",
        "Leonardo Da Vinci",
        "Lorenzo Medici",
        "Mario",
        "Paula",
        "Rosa",
        "Teodora"
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
        
        // get Friend Name for specific row
        let friend = friends[indexPath.row]
        let avatar = avatars[indexPath.row]
        // set Friend Name text for cell
        cell.friendName.text = friend
        cell.friendAvatar.image = avatar
        return cell
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
