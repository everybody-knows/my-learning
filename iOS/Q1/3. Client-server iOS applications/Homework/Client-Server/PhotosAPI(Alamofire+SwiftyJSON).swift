//
//  PhotosAPI.swift
//  Homework
//
//  Created by Александр on 06.01.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class PhotosAPI {
    
    //параметры подключения к VK API
    let baseUrl = "https://api.vk.com/method"
    let userId =  Session.instance.userId
    let accessToken = Session.instance.token
    let version = "5.131"
    
    func getPhotos(friendID: Int, completion: @escaping([PhotosDAO])->()) {
        
        // еще параметры подключения
        print(friendID)
        let path = "/photos.get"
        let url = baseUrl + path
        
        let params: [String: String] = [
            "owner_id": String(friendID),
            "album_id": "wall",
            "extended": "1",
            "access_token": accessToken,
            "v": version
        ]
        // Almofire - выполняем запрос
        AF.request(url, method: .get, parameters: params).responseJSON { response in

            guard let jsonData = response.data else { return }
//            print(response.data?.prettyJSON)
            do {
                // данные полученные от сервер преобразуем в объект
                let itemsData = try JSON(jsonData)["response"]["items"].rawData()
                let photos = try JSONDecoder().decode([PhotosDAO].self, from: itemsData)
                
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
}
