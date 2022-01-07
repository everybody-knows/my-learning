//
//  FriendsAPI.swift
//  Homework
//
//  Created by Александр on 21.12.2021.
//

import Foundation

final class FriendsAPI {

    func getFriends(completion: @escaping([Friends])->()) {
        // конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        // создаем конструктор для URL
        var urlConstructor = URLComponents()
        // устанавливаем схему
        urlConstructor.scheme = "https"
        // устанавливаем хост
        urlConstructor.host = "api.vk.com"
        // путь
        urlConstructor.path = "/method/friends.get"
        // параметры для запроса
        urlConstructor.queryItems = [
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "fields", value: "photo_50")
        ]
        guard let url = urlConstructor.url else { return }
        // задача для запуска
        let task = session.dataTask(with: url) { (data, response, error) in
            // данные полученные от сервера преобразуем в json
            //   let jsonData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? Data
            //  guard let jsonData = data?.prettyJSON else {return}
            // выводим в консоль
            //  print(jsonData)

            // данные полученные от сервер преобразуем в объект
            guard let jsonData = data else {return}
            
            DispatchQueue.main.async {
                do {
                    let friendsContainer = try JSONDecoder().decode(FriendsContainer.self, from: jsonData)
                    let friends = friendsContainer.response.items
                    completion(friends)
                } catch {
                    print(error)
                }
            }
        }
        // запускаем задачу
        task.resume()
    }
    
}
