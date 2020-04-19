//
//  MenuController.swift
//  Restaraunt
//
//  Created by MAC on 17/04/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    let baseURL = URL(string: "http://localhost:8090/")!
    var error = ""
    
    static let shared = MenuController()
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
    static let menuUpdatedNotification = Notification.Name("MenuController.menuDataUpdated")
    
    private var itemsByID = [Int:MenuItem]()
    private var itemsByCategory = [String:[MenuItem]]()
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdateNotification, object: nil)
        }
    }
    
    var categories: [String] {
        get {
            return itemsByCategory.keys.sorted()
        }
    }
    
    private func process(_ items: [MenuItem]) {
        itemsByID.removeAll()
        itemsByCategory.removeAll()
        
        for item in items {
            itemsByID[item.id] = item
            itemsByCategory[item.category, default: []].append(item)
        }
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: MenuController.menuUpdatedNotification, object: nil)
        }
    }
    
    func loadRemoteData()
    {
        let initalMenuURL = baseURL.appendingPathComponent("menu")
        let components = URLComponents(url: initalMenuURL, resolvingAgainstBaseURL: true)!
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, _, _) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                self.process(menuItems.items)
            }
        }
        task.resume()
    }
    
    func loadItems() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: menuItemsFileURL) else { return }
        let items = (try? JSONDecoder().decode([MenuItem].self, from: data)) ?? []
        process(items)
    }
    
    func saveItems() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        let items = Array(itemsByID.values)
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: menuItemsFileURL)
        }
    }
    
//    func fetchCategories(completion: @escaping ([String]?) -> Void)
//    {
//        let categoryURL = baseURL.appendingPathComponent("categories")
//        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
//            if let data = data,
//                let jsonDictionary = try?
//                    JSONSerialization.jsonObject(with: data) as?
//                        [String:Any],
//                let categories = jsonDictionary["categories"] as?
//                    [String] {
//                completion(categories)
//            } else  {
//                completion(nil)
//                self.error = error!.localizedDescription
//            }
//        }
//        task.resume()
//    }
//
//    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void)
//    {
//        let initialMenuURL = baseURL.appendingPathComponent("menu")
//        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
//        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
//        let menuURL = components.url!
//
//        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
//            let jsonDecoder = JSONDecoder()
//            if let data = data,
//                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
//                completion(menuItems.items)
//            } else {
//                completion(nil)
//                self.error = error!.localizedDescription
//            }
//        }
//        task.resume()
//
//    }
    
    func submitOrder(forMenuIds menuIds: [Int], completion: @escaping (Int?) -> Void)
    {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let data: [String: [Int]] = ["menuIds" : menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: orderURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
//                self.error = error!.localizedDescription
            }
        }
        task.resume()
    }
    
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void)
    {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func errorAlert() -> UIAlertController
    {
        let alertContoller = UIAlertController(title: "Something went wrong", message: error, preferredStyle: .alert)
        alertContoller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        return alertContoller
    }
    
    func loadOder() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: orderFileURL) else { return }
        order = (try? JSONDecoder().decode(Order.self, from: data)) ?? Order(menuItems: [])
    }
    
    func saveOrder() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        if let data = try? JSONEncoder().encode(order) {
            try? data.write(to: orderFileURL)
        }
    }
    
    func item(withID itemID: Int) -> MenuItem? {
        return itemsByID[itemID]
    }
    
    func items(forCategory category: String) -> [MenuItem]? {
        return itemsByCategory[category]
    }
    

    
}
