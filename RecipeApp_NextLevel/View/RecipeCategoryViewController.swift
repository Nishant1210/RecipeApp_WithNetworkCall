//
//  RecipeCategoryViewController.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 27/11/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import UIKit

protocol RecipeCategoryViewType {
    func viewReload()
}

class RecipeCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RecipeCategoryViewType {
    
    @IBOutlet weak var collectionList: UICollectionView!
    var categoryPresenter: RecipeCategoryViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionList.delegate = self
        collectionList.dataSource = self
        categoryPresenter?.retrieveRecipeList()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryPresenter?.getTheNumberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCategories", for: indexPath) as? RecipeCategoryCell else {return UICollectionViewCell() }
        cell.setUI(imageName: categoryPresenter?.getImageNameForCell(indexPath: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewFrame = view.frame
        let count = categoryPresenter?.getCategoryCount()
        let heightOfCell = viewFrame.height/CGFloat(count ?? 1)
        if heightOfCell > 30 {
             return CGSize(width: UIScreen.main.bounds.width, height: heightOfCell)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 30.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToRecipeList", let selectCell = sender as? UICollectionViewCell, let indexPath = collectionList.indexPath(for: selectCell) {
            if let presentedVC = segue.destination as? RecipeListViewController {
                let presenter =  RecipeListViewPresenter()
                presentedVC.presenter = presenter
                presenter.recipeList = categoryPresenter?.getCategoryList(indexPath: indexPath.row)
            }
        }
    }
    
    func viewReload() {
        DispatchQueue.main.async {
            self.collectionList.reloadData()
        }
    }
}
