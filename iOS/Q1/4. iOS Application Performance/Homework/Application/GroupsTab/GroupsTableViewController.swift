//
//  GroupsTableViewController.swift
//  Homework
//
//  Created by Пользователь on 09.02.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Firebase

class GroupsTableViewController: UITableViewController {
    
    private var groupsAPI = GroupsAPI()
    
    private var groupsDB = GroupsDB()
    private var groups: Results<GroupsDAO>?
    private var notificationToken: NotificationToken?
    
    //ссылка на контейнер в Firebase
    let refFB = Database.database().reference(withPath: "LoggedUsers/\(Session.instance.userId)/addedGroups")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //удаляем список групп из Realm DB
        self.groups = self.groupsDB.fetch()
        self.groupsDB.delete(groups!)
        
        // получаем список групп
        groupsAPI.getGroups { [weak self] groups  in
            guard let self = self else { return }
            //сохраняем список групп в Realm DB
            self.groupsDB.save(groups)
            //получаем список групп из Realm DB
            self.groups = self.groupsDB.fetch()
            
            //автоматическое обновление при изменении данных в Realm через notifications
            self.notificationToken = self.groups?.observe(on: .main, { [weak self] changes in
                
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let groups = groups else { return 0 }
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupsTableViewCell

        let group = groups?[indexPath.row]
        cell.groupName.text = group?.name
        
        if let url = URL(string: group?.photo50 ?? "") {
            cell.groupAvatar?.sd_setImage(with: url, completed: nil)
        }

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка «Удалить»
        if editingStyle == .delete {
            // Удаляем группу из массива
            // groups.remove(at: indexPath.row)
            // И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        // Проверяем идентификатор, чтобы убедиться, что это нужный переход
        if segue.identifier == "addGroup" {
            // Получаем ссылку на контроллер, с которого осуществлен переход
            guard let searchGroupsController = segue.source as? SearchGroupsTableViewController else {return}
            // Получаем индекс выделенной ячейки
            if let indexPath = searchGroupsController.tableView.indexPathForSelectedRow {
                // Получаем группу по индексу
                let group = searchGroupsController.searchGroups[indexPath.row]
                
                // добавляем группу в Realm
                self.groupsDB.save([group])
                
                //добавляем группу в Firebase
                let groupFB = GroupFB(id: group.id, name: group.name, photo50: group.photo50)
                let groupContainerRef = self.refFB.child(String(group.id))
                groupContainerRef.setValue(groupFB.toAnyObject())
            
            }
        }
    }

}
