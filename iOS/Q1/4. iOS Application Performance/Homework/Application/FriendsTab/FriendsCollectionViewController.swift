//
//  FriendsCollectionViewController.swift
//  Homework
//
//  Created by Александр on 12.03.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class FriendsCollectionViewController: UICollectionViewController {
    
    var friendID: Int = 0
    private var photosAPI = PhotosAPI()
    
    private var photos: Results<PhotosDAO>?
    private var photosDB = PhotosDB()
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //удаляем фотографии из Realm DB
        self.photos = self.photosDB.fetch()
        self.photosDB.delete(photos!)
        
        // получаем фотографии
        photosAPI.getPhotos(friendID: friendID) { [weak self] photos  in
            guard let self = self else { return }
            //сохраняем список групп в Realm DB
            self.photosDB.save(photos)
            //получаем список групп из Realm DB
            self.photos = self.photosDB.fetch()
            
            //автоматическое обновление при изменении данных в Realm через notifications
            self.notificationToken = self.photos?.observe(on: .main, { [weak self] changes in
                
                guard let collectionView = self?.collectionView else { return }
                switch changes {
                case .initial:
                    collectionView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    collectionView.performBatchUpdates({
                        collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                        collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                        collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                    }, completion: nil)
                case .error(let error):
                    fatalError("\(error)")
                }

            })
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard let photos = photos else { return 0 }
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendImageCell", for: indexPath) as! FriendsCollectionViewCell
    
        let photo = photos?[indexPath.row]
        if let url = URL(string: (photo?.sizes[0].url)!) {
            cell.friendImage?.sd_setImage(with: url, completed: nil)
        }
        return cell
    }

}
