//
//  RecipeDescriptionViewPresenter.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 04/12/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import Foundation

protocol RecipeDescriptionViewPresenterProtocol: class {
    func getNumberOfRows() -> Int
    func getIngredientList(indexPath : Int) -> String
    func getPreparationTimeDescription() -> String
    func getRecipeDescription() -> String
    func getTitleName() -> String
    func getRecipeLink() -> String
    func getIngredientsList() -> [IngredientsRequiredList]?
    func updateIngredientToRecipeList()
}

class RecipeDescriptionViewPresenter: RecipeDescriptionViewPresenterProtocol {
    
    var deliciousrecipe : RecipeDescriptionModal?
    var recipesListDescription : RecipesListDescription?
    var ingredientToRecipeList: IngredientsRequired?
    var recipeDescriptionViewType: RecipeDescriptionViewType
    
    init(_ view: RecipeDescriptionViewType) {
        self.recipeDescriptionViewType = view
    }
    
//    func getDataFromIngredientRecipeMappingJsonJSON(filename fileName: String) -> IngredientsRequired? {
//        var ingredientsRequired: IngredientsRequired?
//        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                ingredientsRequired = try JSONDecoder().decode(IngredientsRequired.self, from:data)
//            } catch {
//                print("Error!! Unable to parse  \(fileName).json")
//            }
//        }
//        return ingredientsRequired
//    }
    
    func getDataFromIngredientRecipeMappingJSON() {
        if let ingredientRecipeMappingURL = NSURL(string: "https://www.mocky.io/v2/5df0dee03100000f008f0bbd") {
            URLSession.shared.dataTask(with: ingredientRecipeMappingURL as URL) { (data, response, error) in
                if let data = data, error == nil {
                    do {
                        self.ingredientToRecipeList = try JSONDecoder().decode(IngredientsRequired.self, from:data)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else if let err = error {
                    print(err.localizedDescription)
                }
                }.resume()
        }
    }
    
    func getNumberOfRows() -> Int {
        return deliciousrecipe?.ingredients.count ?? 0
    }
    
    func getIngredientList(indexPath : Int) -> String {
        return deliciousrecipe?.ingredients[indexPath] ?? ""
    }
    
    func getRecipeDescription() -> String {
        return deliciousrecipe?.description ?? "No description available"
    }
    
    func getPreparationTimeDescription() -> String {
        return deliciousrecipe?.preparationTime ?? "No preparation time available"
    }
    
    func getTitleName() -> String {
        return deliciousrecipe?.title ?? "No title available"
    }
    
    func getRecipeLink() -> String {
        return deliciousrecipe?.recipeLink ?? "www.youtube.com"
    }
    
    func getIngredientsList() -> [IngredientsRequiredList]? {
        return ingredientToRecipeList?.ingredients
    }
    
    func updateIngredientToRecipeList() {
        if ingredientToRecipeList == nil {
            getDataFromIngredientRecipeMappingJSON()
        }
    }
    
}
