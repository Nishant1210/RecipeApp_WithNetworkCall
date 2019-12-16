//
//  NetworkController.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 11/12/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import Foundation

class NetworkHandler {
    
    static let sharedInstance = NetworkHandler()
    struct urlConstant {
        static let recipeListUrl = "https://www.mocky.io/v2/5df0c7843100006b008f0ad3"
        static let recipeDescriptionURL = "https://www.mocky.io/v2/5df0e43731000066008f0bec"
        static let ingredientToRecipeMappingUrl = "https://www.mocky.io/v2/5df0dee03100000f008f0bbd"
    }
    
    var session = URLSession(configuration: .default)
    
    
//    func retrieveRecipeList(_ completion: @escaping (DataCategory?) -> Void) {
//        var dataCategory: DataCategory? = nil
//        if let recipeURL = URL(string: urlConstant.recipeListUrl) {
//        session.dataTask(with: recipeURL) { (data, response, error) in
//                if let data = data, error == nil {
//                    do {
//                        dataCategory = try JSONDecoder().decode(DataCategory.self, from:data)
//                    } catch {
//                        print("Not available")
//                    }
//                } else {
//                    print(error)
//                }
//            completion(dataCategory)
//            }.resume()
//        }
//    }
}
