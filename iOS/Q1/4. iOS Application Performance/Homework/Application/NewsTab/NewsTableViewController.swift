//
//  NewsTableViewController.swift
//  Homework
//
//  Created by Александр on 11.06.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let newsAuthorImage: UIImage = UIImage(named: "GroupIcon.png")!
    let imageCarnival: UIImage = UIImage(named: "Сarnival")!

    override func viewDidLoad() {
        super.viewDidLoad()

        
 //       tableView.register(UINib(nibName: "NewsTableViewAuthorCell", bundle: nil), forCellReuseIdentifier: "newsAuthorCell")
 //g       tableView.register(UINib(nibName: "NewsTableViewTextCell", bundle: nil), forCellReuseIdentifier: "newsTextCell")

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
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsAuthorCell", for: indexPath) as! NewsTableViewAuthorCell
            cell.newsAuthorImage.image = newsAuthorImage
            cell.newsAuthorName.text = "News Author Name"
            cell.newsDate.text = "Today"
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as! NewsTableViewTextCell
            //cell.newsTextView.text = "Hello world"
            
            self.tableView.estimatedRowHeight = 166.0;
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsImageCell", for: indexPath) as! NewsTableViewImageCell
            cell.newsImageView.image = imageCarnival
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsLikesAndCommentsCell", for: indexPath) as! NewsTableViewLikesAndCommentsCell
            cell.newsLikesCount.text = "5"
            cell.newsCommentsCount.text = "11"
            return cell
        }
        
        return UITableViewCell()
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
