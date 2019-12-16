//
//  ViewController.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 27/11/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeButton: UIButton!
    var dataCategory: DataCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkHandler.sharedInstance.retrieveRecipeList { (data) in
//            self.dataCategory = data
//        }
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity:memoryCapacity , diskCapacity: diskCapacity, diskPath: "myDiskSpace")
        URLCache.shared = urlCache
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeCategoryViewController = segue.destination as? RecipeCategoryViewController, segue.identifier == "welcomeToCategories"{
            let categoryListPresenter = RecipeCategoryViewPresenter(recipeCategoryViewController)
            recipeCategoryViewController.categoryPresenter = categoryListPresenter
        }
    }
}

