//
//  RecipeCategoryViewPresenter.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 04/12/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import Foundation

protocol RecipeCategoryViewPresenterProtocol: class {
    func getTheNumberOfRows() -> Int?
    func getImageNameForCell(indexPath : Int) -> String
    func getCategoryList(indexPath : Int) -> [RecipeCategoryModal]?
    func getCategoryCount() -> Int
    func updateDataCategory(dataCategory: DataCategory?)
    func retrieveRecipeList()
}

class RecipeCategoryViewPresenter: RecipeCategoryViewPresenterProtocol {
    var dataCategory: DataCategory?
    var recipeCategoryViewType: RecipeCategoryViewType
    let cacheController = CacheController()
    
    init(_ view: RecipeCategoryViewType) {
        self.recipeCategoryViewType = view
    }
    
//    func getDataFromFoodRecipeJSON(filename fileName: String) -> DataCategory? {
//        var category: DataCategory?
//        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                category = try JSONDecoder().decode(DataCategory.self, from:data)
//            } catch {
//                print("Error!! Unable to parse  \(fileName).json")
//            }
//        }
//        return category
//    }
    
    func getTheNumberOfRows() -> Int? {
        return dataCategory?.categories.count ?? 0
    }
    
    func getImageNameForCell(indexPath : Int) -> String {
        return dataCategory?.categories[indexPath].categoryName ?? "No Image Found"
    }
    
    func getCategoryList(indexPath : Int) -> [RecipeCategoryModal]? {
        return dataCategory?.categories[indexPath].categoryList
    }
    
    func getCategoryCount() -> Int {
        return dataCategory?.categories.count ?? 1
    }
    
    func updateDataCategory(dataCategory: DataCategory?) {
        self.dataCategory = dataCategory
    }
    
    func retrieveRecipeList() {
        if let recipeURL = URL(string: "https://www.mocky.io/v2/5df0c7843100006b008f0ad3") {
            URLSession.shared.dataTask(with: recipeURL) { (data, response, error) in
                if let data = data, error == nil {
                    do {
                        self.dataCategory = try JSONDecoder().decode(DataCategory.self, from:data)
                        try self.cacheController.saveCache(forName: "DataCategory", withContent: self.dataCategory)
                        self.recipeCategoryViewType.viewReload()
                    } catch {
                        print("Not available")
                    }
                } else {
                    print(error)
                }
                }.resume()
        }
    }
}
