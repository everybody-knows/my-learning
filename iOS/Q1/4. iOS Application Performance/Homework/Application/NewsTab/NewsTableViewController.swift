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
    
}
