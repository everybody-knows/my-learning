//
//  FriendsTableViewController.swift
//  Homework
//
//  Created by Пользователь on 08.02.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friendsDictionary = [String: [String]]()
    var friendSectionTitles = [String]()
    var friends = [
        "Bartolomeo",
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
        
        for friend in friends {
            let friendKey = String(friend.prefix(1))
                if var friendValues = friendsDictionary[friendKey] {
                    friendValues.append(friend)
                    friendsDictionary[friendKey] = friendValues
                } else {
                    friendsDictionary[friendKey] = [friend]
                }
        }
        
        friendSectionTitles = [String](friendsDictionary.keys)
        friendSectionTitles = friendSectionTitles.sorted(by: { $0 < $1 })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return friendSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let friendKey = friendSectionTitles[section]
            if let friendValues = friendsDictionary[friendKey] {
                return friendValues.count
            }
                
            return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell

        cell.friendAvatar.layer.cornerRadius = cell.friendAvatar.bounds.height / 2
        
        let friendKey = friendSectionTitles[indexPath.section]
            if let friendValues = friendsDictionary[friendKey] {
                cell.friendName?.text = friendValues[indexPath.row]
                cell.friendAvatar?.image = UIImage(named:friendValues[indexPath.row])!
            }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                tapGestureRecognizer.numberOfTapsRequired = 1
        cell.friendAvatarShadow.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return friendSectionTitles
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
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
        {
            let imgView = tapGestureRecognizer.view
            let animation = CASpringAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
            animation.toValue = 0.90
            animation.stiffness = 800
            animation.mass = 0
            animation.duration = 0.75
            animation.fillMode = CAMediaTimingFillMode.backwards

            imgView?.layer.add(animation, forKey: nil)
            
        }

}
