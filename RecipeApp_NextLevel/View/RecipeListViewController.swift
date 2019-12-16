//
//  RecipeListViewController.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 27/11/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 
    var comingFromIngredients: Bool = false
    var presenter: RecipeListViewPresenterProtocol?
    @IBOutlet weak var recipeListTableView: UITableView!
    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var ingredientDescription: UILabel!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeListTableView.delegate = self
        recipeListTableView.dataSource = self
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIOnViewWillAppear()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInListBasedOnRecipes() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeListingCell") as? RecipeListingTableViewCell else {return UITableViewCell()}
        cell.setUpUI(text: presenter?.getRecipeListName(indexPath: indexPath.row))
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDeccriptionSegue", let recipeDescriptionVC = segue.destination as? RecipeDescriptionViewController,let selectCell = sender as? UITableViewCell, let indexPath = recipeListTableView.indexPath(for: selectCell), let presenter = presenter {
            recipeDescriptionVC.listParent = self
            let rvpresenter = RecipeDescriptionViewPresenter(recipeDescriptionVC)
            recipeDescriptionVC.presenter = rvpresenter
            rvpresenter.deliciousrecipe = presenter.searchRecipeId(recipeID: presenter.getRecipeId(indexPath:indexPath.row))
        }
    }
    
    func updateUI(){
        guard let presenter = presenter else { return }
        ingredientDescription.text = presenter.getIngredientName()
        ingredientImageView.image = UIImage(named: (presenter.getIngredientName() ?? ""))
        presenter.updateRecipeList(recipeList: presenter.getRecipeList())
    }
    
    func updateUIOnViewWillAppear() {
        if !comingFromIngredients {
            ingredientImageView.isHidden = true
            ingredientDescription.isHidden = true
            tableViewTopConstraint.priority = UILayoutPriority(999)
        } else {
            ingredientImageView.isHidden = false
            ingredientDescription.isHidden = false
            tableViewTopConstraint.priority = UILayoutPriority(751)
            updateUI()
            recipeListTableView.reloadData()
        }
    }
}
