//
//  WebViewLoginFormController.swift
//  Homework
//
//  Created by Александр on 15.12.2021.
//

import UIKit
import WebKit

class WebViewLoginFormController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView! {
        didSet{
                    webView.navigationDelegate = self
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorize()
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
                    .components(separatedBy: "&")
                    .map { $0.components(separatedBy: "=") }
                    .reduce([String: String]()) { result, param in
                        var dict = result
                        let key = param[0]
                        let value = param[1]
                        dict[key] = value
                        return dict
                }
        
        guard let token = params["access_token"], let userId = params["user_id"] else {
            print("ERROR: Сould not get response parameters")
            return
        }
        decisionHandler(.cancel)
        
        Session.instance.token = token
        Session.instance.userId = Int(userId) ?? -1
        
        print("TOKEN= \(token)")
        
        /// -------------------------------------------------------------------------
        /// Пока шлем запросы к VK API здесь, в дальнейшем, необходимо их перенести
        /// в соответсвующие контроллеры - запросы будут выполняться по мере открытия вкладок.
        /// -------------------------------------------------------------------------
    
        //Получаем список друзей
        getUserFriends()
        
        //Получаем список групп
        getUserGroups()
        
        //Получаем список групп из "строки поиска"
        getSearchGroups()
        
        //Получаем фотографии пользователя
        getUserPhotos()
        
        //Обязательно выполнить перед коммитом в GitHub: "Бэ" - Бэзопастность! :)
        WebCacheCleaner.clean()
        
        /// -------------------------------------------------------------------------

        //Переход на таббар
        performSegue(withIdentifier: "tabBarSegue", sender: nil)
            
    }
    
    func authorize() {
        // Создаем конструктор для URL
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7822904"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "262150"),
                    // URLQueryItem(name: "revoke", value: "1"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.68")
                ]
        // Создаем запрос
        let request = URLRequest(url: urlComponents.url!)
        // Отправляем запорс в webView
        webView.load(request)
    }
    
    func getUserFriends() {
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
                urlConstructor.path = "/method/friends.get"
        // параметры для запроса
                urlConstructor.queryItems = [
                    URLQueryItem(name: "v", value: "5.131"),
                    URLQueryItem(name: "access_token", value: Session.instance.token)
                ]
        guard let url = urlConstructor.url else {
            print("ERROR: ERROR: Сould not create URL")
            return
        }
        // задача для запуска
        let task = session.dataTask(with: url) { (data, response, error) in
        // в замыкании данные, полученные от сервера, мы преобразуем в json
                    let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
        // выводим в консоль
                    print(json ?? "ERROR: Сould not get JSON")
                }
        // запускаем задачу
                task.resume()
    }
    
    func getUserGroups() {
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
                urlConstructor.path = "/method/users.getSubscriptions"
        // параметры для запроса
                urlConstructor.queryItems = [
                    URLQueryItem(name: "v", value: "5.131"),
                    URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
                    URLQueryItem(name: "access_token", value: Session.instance.token)
                ]
        guard let url = urlConstructor.url else {
            print("ERROR: ERROR: Сould not create URL")
            return
        }
        // задача для запуска
        let task = session.dataTask(with: url) { (data, response, error) in
        // в замыкании данные, полученные от сервера, мы преобразуем в json
                    let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
        // выводим в консоль
                    print(json ?? "ERROR: Сould not get JSON")
                }
        // запускаем задачу
                task.resume()
    }
    
    func getSearchGroups() {
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
                    URLQueryItem(name: "q", value: "assassin's creed"),
                    URLQueryItem(name: "access_token", value: Session.instance.token)
                ]
        guard let url = urlConstructor.url else {
            print("ERROR: ERROR: Сould not create URL")
            return
        }
        // задача для запуска
        let task = session.dataTask(with: url) { (data, response, error) in
        // в замыкании данные, полученные от сервера, мы преобразуем в json
                    let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
        // выводим в консоль
                    print(json ?? "ERROR: Сould not get JSON")
                }
        // запускаем задачу
                task.resume()
    }
    
    func getUserPhotos() {
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
                urlConstructor.path = "/method/photos.get"
        // параметры для запроса
                urlConstructor.queryItems = [
                    URLQueryItem(name: "v", value: "5.131"),
                    URLQueryItem(name: "owner_id", value: String(Session.instance.userId)),
                    URLQueryItem(name: "album_id", value: "profile"),
                    URLQueryItem(name: "access_token", value: Session.instance.token)
                ]
        guard let url = urlConstructor.url else {
            print("ERROR: ERROR: Сould not create URL")
            return
        }
        // задача для запуска
        let task = session.dataTask(with: url) { (data, response, error) in
        // в замыкании данные, полученные от сервера, мы преобразуем в json
                    let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
        // выводим в консоль
                    print(json ?? "ERROR: Сould not get JSON")
                }
        // запускаем задачу
                task.resume()
    }
    
    //Clear WKWebView's cookies and website data storage
    final class WebCacheCleaner {
        
        class func clean() {
            HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
            print("[WebCacheCleaner] All cookies deleted")
            
            WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                records.forEach { record in
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                    print("[WebCacheCleaner] Record \(record) deleted")
                }
            }
        }
        
    }

}
