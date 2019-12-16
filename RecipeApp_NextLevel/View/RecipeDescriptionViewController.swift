//
//  RecipeDescriptionViewController.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 27/11/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import UIKit
import SafariServices

protocol RecipeDescriptionViewType {
    func reloadView()
}

class RecipeDescriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RecipeDescriptionViewType {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var descriptionOfRecipe: UITextView!
    @IBOutlet weak var ingredientsList: UITableView!
    @IBOutlet weak var valueOfPreparationTime: UILabel!
    @IBOutlet weak var titleOfRecipe: UILabel!
    var presenter: RecipeDescriptionViewPresenterProtocol?
    var indexValue: Int = 0
    weak var listParent: RecipeListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsList.dataSource = self
        ingredientsList.delegate = self
        updateUIOfPageLoad()
        presenter?.updateIngredientToRecipeList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientListCell") as? RecipeIngredientsListCell else { return UITableViewCell() }
        cell.setUpUI(text: presenter?.getIngredientList(indexPath: indexPath.row))
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexValue = indexPath.row
        if let parentVC = self.listParent, let ingredientCell = tableView.cellForRow(at: indexPath) as? RecipeIngredientsListCell, let ingredientName = ingredientCell.ingredientItemLabel.text {
            parentVC.comingFromIngredients = true
            parentVC.presenter?.updateIngredientsRequiredList(ingredientsRequiredList: searchListOfRecipesOnIngredientName(ingredientName: ingredientName))
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func watchVideosAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        let videoUrl = URL(string: presenter.getRecipeLink())
        let safariVC = SFSafariViewController(url: videoUrl!)
        present(safariVC, animated: true, completion: nil)
    }
    
    func searchListOfRecipesOnIngredientName(ingredientName: String) -> IngredientsRequiredList? {
        if let ingredientsName = presenter?.getIngredientsList(), let indexValue = ingredientsName.firstIndex(where: {$0.ingredientName == ingredientName}) {
            return ingredientsName[indexValue]
        }
        return nil
    }
    
    func updateUIOfPageLoad() {
        guard let presenter = presenter else { return }
        descriptionOfRecipe.text = presenter.getRecipeDescription()
        valueOfPreparationTime.text = presenter.getPreparationTimeDescription()
        titleOfRecipe.text = presenter.getTitleName()
        recipeImage.image = UIImage(named: presenter.getTitleName())
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.updateUIOfPageLoad()
            self.ingredientsList.reloadData()
        }
    }
}
