//
//  RecipeDescriptionViewPresenterTest.swift
//  RecipeApp_NextLevelTests
//
//  Created by tesco on 05/12/19.
//  Copyright © 2019 tesco. All rights reserved.
//
//

import Foundation
import XCTest
@testable import RecipeApp_NextLevel

class RecipeDescriptionViewPresenterTest : XCTestCase {
    
    var recipeDescriptionViewPresenter = RecipeDescriptionViewPresenter(<#RecipeDescriptionViewType#>)
    var mockedRecipeDecriptionList: RecipeDescriptionModal = {
        let recipeList1 = RecipeDescriptionModal()
        recipeList1.id = "0001"
        recipeList1.description = "Eggless chocolate cake recipe with video & step by step photos – This simple moist, soft chocolate cake has no butter, no eggs, no milk in it except for the frosting which uses little butter & milk. This cake is made with almost very basic ingredients and is popularly known as wacky cake or depression cake."
        recipeList1.title = "Eggless Cakes"
        recipeList1.ingredients = ["Flour", "Milk", "Baking powder", "Baking soda", "Cocoa", "Butter"]
        recipeList1.preparationTime = "2 Hours"
        recipeList1.recipeLink = "https://www.youtube.com/watch?v=PmqdA05OXuI"
        return recipeList1
    }()
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetRecipeLinK() {
        recipeDescriptionViewPresenter.deliciousrecipe = mockedRecipeDecriptionList
        let recipeLink = recipeDescriptionViewPresenter.getRecipeLink()
        XCTAssertEqual(recipeLink, "https://www.youtube.com/watch?v=PmqdA05OXuI" )
        
    }
    
    func testGetRecipeLink() {
        recipeDescriptionViewPresenter.deliciousrecipe = mockedRecipeDecriptionList
        let recipeTitle = recipeDescriptionViewPresenter.getTitleName()
        XCTAssertEqual(recipeTitle, "Eggless Cakes")
    }
    
    func testGetPreparationTimeDescription() {
        recipeDescriptionViewPresenter.deliciousrecipe = mockedRecipeDecriptionList
        let preparationTime = recipeDescriptionViewPresenter.getPreparationTimeDescription()
        XCTAssertEqual(preparationTime, "2 Hours")
    }
    
    func testGetRecipeDescription() {
        recipeDescriptionViewPresenter.deliciousrecipe = mockedRecipeDecriptionList
        let recipeDescription = recipeDescriptionViewPresenter.getRecipeDescription()
        XCTAssertEqual(recipeDescription, "Eggless chocolate cake recipe with video & step by step photos – This simple moist, soft chocolate cake has no butter, no eggs, no milk in it except for the frosting which uses little butter & milk. This cake is made with almost very basic ingredients and is popularly known as wacky cake or depression cake.")
    }
    
        func testListOfIngredients() {
           recipeDescriptionViewPresenter.updateIngredientToRecipeList()
            let ingredientMappedList = recipeDescriptionViewPresenter.getIngredientsList()
            XCTAssertEqual(ingredientMappedList?[0].ingredientName, "Flour")
        }
    
    func testIngredientName() {
        recipeDescriptionViewPresenter.deliciousrecipe = mockedRecipeDecriptionList
        let nameOfIngredientName = recipeDescriptionViewPresenter.getIngredientList(indexPath: 0)
        XCTAssertEqual(nameOfIngredientName,"Flour")
        
    }
}

