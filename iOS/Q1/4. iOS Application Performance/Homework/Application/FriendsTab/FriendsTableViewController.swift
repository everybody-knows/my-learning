//
//  FriendsTableViewController.swift
//  Homework
//
//  Created by Пользователь on 08.02.2021.
//

import UIKit
import SDWebImage
import RealmSwift

final class FriendsTableViewController: UITableViewController {
    
    private var friendsAPI = FriendsAPI()
//    private var friends: [Friends] = []
    private var friends: Results<FriendsDAO>?
    private var friendsDB = FriendsDB()
    private var friendsDictionary = [String: [FriendsDAO]]()
    private var friendSectionTitles = [String]()
    private var notificationToken: NotificationToken?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //удаляем список друзей из Realm DB
        self.friends = self.friendsDB.fetch()
        self.friendsDB.delete(friends!)
        
        // получаем список друзей
        friendsAPI.getFriends { [weak self] friends  in
            guard let self = self else { return }
//            //сохраняем список друзей в струкруре Friends
//            self.friends = friends
            //сохраняем список групп в Realm DB
            self.friendsDB.save(friends)
            //получаем список групп из Realm DB
            self.friends = self.friendsDB.fetch()
              
            
            // формируем заголовки для секций ф таблице
            for friend in friends {
                let friendKey = String(friend.lastName.prefix(1))
                if var friendValues = self.friendsDictionary[friendKey] {
                        friendValues.append(friend)
                        self.friendsDictionary[friendKey] = friendValues
                    } else {
                        self.friendsDictionary[friendKey] = [friend]
                    }
           }
            // сортируем заголовки для секций
            self.friendSectionTitles = [String](self.friendsDictionary.keys)
            self.friendSectionTitles = self.friendSectionTitles.sorted(by: { $0 < $1 })

            //self.tableView.reloadData()
            
            //автоматическое обновление при изменении данных в Realm через notifications
            self.notificationToken = self.friends?.observe(on: .main, { [weak self] changes in
                
                guard let self = self else { return }
                
                switch changes {
                case .initial:
                    self.tableView.reloadData()
                    
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                    
                case .error(let error):
                    print("\(error)")
                }

            })
            
        }
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print(friendSectionTitles.count)
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
                let friend = friendValues[indexPath.row]
                cell.friendName?.text = "\(friend.lastName) \(friend.firstName)"
               // cell.friendAvatar?.image = UIImage(named:friendValues[indexPath.row])!
                if let url = URL(string: friend.photo50) {
                    cell.friendAvatar?.sd_setImage(with: url, completed: { image, _, _, _ in
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    })
                }
                
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
        
    //анимация при нажатии на аватар
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
    
    //передаем ID выбранного друга в FriendsCollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendPhotoSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let friendKey = friendSectionTitles[indexPath.section]
                let friendID = friendsDictionary[friendKey]?[indexPath.row].id
                guard let FriendsCollectionController = segue.destination as? FriendsCollectionViewController else { return }
                FriendsCollectionController.friendID = friendID!
            }
        }
    }

}
