//
//  GroupsAPI.swift
//  Homework
//
//  Created by Александр on 05.01.2022.
//

import Foundation

final class GroupsAPI {
    
    func getGroups(completion: @escaping([Groups])->()) {
        // Конфигурация по умолчанию
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
                urlConstructor.path = "/method/groups.get"
        // параметры для запроса
                urlConstructor.queryItems = [
                    URLQueryItem(name: "v", value: "5.131"),
                    URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
                    URLQueryItem(name: "access_token", value: Session.instance.token),
                    URLQueryItem(name: "extended", value: "1")
                   // URLQueryItem(name: "fields", value: "id, name, photo_50")
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
                            let jsonData: Any = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            let jsonObject = jsonData as! [String: Any]
                            let response = jsonObject["response"] as! [String: Any]
                            let items = response["items"] as! [Any]
                            let groups = items.map { Groups(item: $0 as! [String: Any]) }
                            completion(groups)
                        } catch {
                            print(error)
                        }
                    }
                }
        // запускаем задачу
                task.resume()
    }
    
    func searchGroups(searchText: String, completion: @escaping([Groups])->()) {
        // Конфигурация по умолчанию
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
                urlConstructor.path = "/method/groups.search"
        // параметры для запроса
                urlConstructor.queryItems = [
                    URLQueryItem(name: "v", value: "5.131"),
                    URLQueryItem(name: "q", value: searchText),
                    URLQueryItem(name: "type", value: "group"),
                    URLQueryItem(name: "access_token", value: Session.instance.token)
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
                    let jsonData: Any = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    let jsonObject = jsonData as! [String: Any]
                    let response = jsonObject["response"] as! [String: Any]
                    let items = response["items"] as! [Any]
                    
                    let searchGroups = items.map { Groups(item: $0 as! [String: Any]) }
                    completion(searchGroups)
                } catch {
                    print(error)
                }
            }
        }
// запускаем задачу
        task.resume()
    }
}
