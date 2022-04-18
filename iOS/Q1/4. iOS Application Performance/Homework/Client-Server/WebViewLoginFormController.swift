//
//  WebViewLoginFormController.swift
//  Homework
//
//  Created by Александр on 15.12.2021.
//

import UIKit
import WebKit
import Firebase

class WebViewLoginFormController: UIViewController, WKNavigationDelegate {
    
    //ссылка на контейнер в Firebase
    let refFB = Database.database().reference(withPath: "LoggedUsers")

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
        
        guard let token = params["access_token"], let userId = params["user_id"] else { return }
        decisionHandler(.cancel)
        
        //сохраняем токен и id пользователя в Session
        Session.instance.token = token
        Session.instance.userId = Int(userId) ?? -1
        
        ///добавляем пользователя в Firebase
        let userFB = UserFB(id: Int(userId) ?? -1, addedGroups: [])
        let usersContainerRef = self.refFB.child(userId)
        usersContainerRef.setValue(userFB.toAnyObject())
        
        print("TOKEN= \(token)")
        
        //Обязательно выполнить перед коммитом в GitHub: "Бэ" - Бэзопастность! :)
        WebCacheCleaner.clean()

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
