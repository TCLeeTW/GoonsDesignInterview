//
//  MainVC.swift
//  GoonsDesignInterview
//
//  Created by TC Lee on 2023/10/25.
//

import UIKit

class MainVC: UIViewController {
    
    

    let searchController = UISearchController()
    
    let headerView : UIView = {
        let view = UIView()
        
        return view
    }()
    let titleView: UILabel = {
        let label = UILabel()
        label.text = "Repo Searcher"
        label.textAlignment = .left
        label.font = UIFont(name: "system", size: 17)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Repository Search"
        configureSearchHeader()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 100)
        titleView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 50)
        searchController.searchBar.frame = CGRect(x: 0, y: 50, width: self.view.width-40, height: 50)
    }
    
    private func configureSearchHeader(){
        
//        navigationItem.titleView = searchController.searchBar
        headerView.addSubview(titleView)
        headerView.addSubview(searchController.searchBar)
        navigationItem.titleView = headerView
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.placeholder = "Search Github Repository"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.searchTextField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainVC:UISearchBarDelegate{
   
}
extension MainVC:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    
}

extension MainVC:UITextFieldDelegate{
    
}
