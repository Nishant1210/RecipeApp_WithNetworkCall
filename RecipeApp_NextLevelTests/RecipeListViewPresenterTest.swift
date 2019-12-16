//
//  RecipeListViewPresenterTest.swift
//  RecipeApp_NextLevelTests
//
//  Created by tesco on 05/12/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import Foundation
import XCTest
@testable import RecipeApp_NextLevel

var mockedIngredientsRequiredList: IngredientsRequiredList = {
    let ingredientsRequiredList1 = IngredientsRequiredList()
    ingredientsRequiredList1.ingredientDescription = "Flour"
    ingredientsRequiredList1.ingredientName = "Flour"
    let recipe1 = RecipeCategoryModal()
    let recipe2 = RecipeCategoryModal()
    recipe1.id = "0001"
    recipe1.recipeName = "Cakes"
    recipe2.id = "0002"
    recipe2.recipeName = "CupCakes"
    ingredientsRequiredList1.recipeList = [recipe1, recipe2]
    return ingredientsRequiredList1
}()

class RecipeListViewPresenterTest: XCTestCase {
    
//    var recipeListViewPresenter = RecipeListViewPresenter()
//    var recipeList: [RecipeCategoryModal]?
//    var recipeDescriptionList: RecipesListDescription?
//    var ingredientsRequiredList: IngredientsRequiredList?
//    
//    override func setUp() {
//        
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
    
}
