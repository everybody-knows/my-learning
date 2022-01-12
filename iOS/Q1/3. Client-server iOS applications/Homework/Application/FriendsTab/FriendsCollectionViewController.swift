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
//    private var photos: [PhotosDTO] = []
    
    private var photos: Results<PhotosDAO>?
    private var photosDB = PhotosDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        // получаем фотографии
        photosAPI.getPhotos(friendID: friendID) { [weak self] photos  in
            guard let self = self else { return }
//            //сохраняем фотографии в струкруре Photos
//            self.photos = photos
            //удаляем все из Realm DB
            self.photosDB.deleteAll()
            //сохраняем список групп в Realm DB
            self.photosDB.save(photos)
            //получаем список групп из Realm DB
            self.photos = self.photosDB.fetch()
            
            
            self.collectionView.reloadData()

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
