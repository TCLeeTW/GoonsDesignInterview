//
//  MainVC.swift
//  GoonsDesignInterview
//
//  Created by TC Lee on 2023/10/25.
//

import UIKit

class MainVC: UIViewController {
    
    

    let searchController = UISearchController()
    var resultTableView = UITableView()
    var searchResult:[Repo]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchHeader()
        configureTableView()
        resultTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.identifier)
        
        // Setting up the delegate
        searchController.delegate = self
        searchController.searchBar.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultTableView.frame = view.bounds
    }

    
    private func configureSearchHeader(){
        
        navigationItem.titleView = searchController.searchBar
       
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.placeholder = "Search Github Repository"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.searchTextField.resignFirstResponder()
    }

    func configureTableView(){
        resultTableView = UITableView()
        self.view.addSubview(resultTableView)
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
    
    func search(keyword:String){
        
        communicator.shared.searchRepo(keyword: keyword.lowercased()) { result in
            switch result {
            case .success(let repos):
                self.searchResult = repos
                print(repos[2])
                self.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.resultTableView.reloadData()
        }
    }

}

extension MainVC:UISearchControllerDelegate,UISearchBarDelegate,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
  
}


extension MainVC:UITextFieldDelegate{
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Triggered when user clicked clear button.
        print("clear button clicked")
        searchResult = []
        reloadTableView()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = textField.text,
           !keyword.isEmpty{
            search(keyword: keyword)
        }
        return true
    }
}

extension MainVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier) as! RepoTableViewCell
        let repo = searchResult[indexPath.row]
        if repo.owner.avatar_url != nil,
           let url = URL(string: repo.owner.avatar_url){
            communicator.shared.getIcon(url: url) { result in
                switch result{
                case .failure(_):
                    cell.repoImage.image = UIImage()
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.repoImage.image = image
                    }
                }
            }
            
        }else{
            cell.repoImage.image = UIImage()
        }
        
        cell.repo = repo
        cell.repoTitle.text = repo.full_name
        cell.repoDescription.text = repo.description
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
