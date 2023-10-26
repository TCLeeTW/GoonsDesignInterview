//
//  DetailVC.swift
//  GoonsDesignInterview
//
//  Created by TC Lee on 2023/10/26.
//

import UIKit

class DetailVC: UIViewController {
    
    init (model: Repo,repoimage:UIImage){
        self.repo = model
        self.repoImage = repoimage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var repo:Repo!
    var repoImage:UIImage!
    
    let repoName:UILabel={
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    let repoFullName:UILabel={
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    let repoLanguage:UILabel={
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    let repoImageView:UIImageView={
        let imageView = UIImageView()
        return imageView
    }()
    let stars:UILabel={
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    let watchers:UILabel={
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    let forks:UILabel={
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    let issues:UILabel={
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setContent()
        addSubviews()
        navigationController?.navigationBar.tintColor = .black
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let padding:CGFloat = 20
        let imageWidth = self.view.width - padding*2
        
        let navBottom = navigationController!.navigationBar.bottom
        
        repoName.frame = CGRect(x: padding, y: navBottom, width: imageWidth, height: repoName.intrinsicContentSize.height)
        repoImageView.frame = CGRect(x: padding,
                                     y: repoName.bottom + padding,
                                     width: imageWidth,
                                     height: imageWidth)
        repoFullName.frame = CGRect(x: centerAlign(self.view.width, repoFullName.intrinsicContentSize.width),
                                    y: repoImageView.bottom + padding,
                                    width: repoFullName.intrinsicContentSize.width,
                                    height: repoFullName.intrinsicContentSize.height)
        repoLanguage.frame = CGRect(x: padding,
                                    y: repoFullName.bottom + padding,
                                    width: repoLanguage.intrinsicContentSize.width,
                                    height: repoLanguage.intrinsicContentSize.height)
        stars.frame = CGRect(x: view.width - stars.intrinsicContentSize.width - padding,
                             y: repoLanguage.top,
                             width: stars.intrinsicContentSize.width,
                             height: stars.intrinsicContentSize.height)
        watchers.frame = CGRect(x: view.width - watchers.intrinsicContentSize.width - padding,
                             y: stars.bottom + padding,
                             width: watchers.intrinsicContentSize.width,
                             height: watchers.intrinsicContentSize.height)
        forks.frame = CGRect(x: view.width - forks.intrinsicContentSize.width - padding,
                             y: watchers.bottom + padding,
                             width: forks.intrinsicContentSize.width,
                             height: forks.intrinsicContentSize.height)
        issues.frame = CGRect(x: view.width - issues.intrinsicContentSize.width - padding,
                              y: forks.bottom + padding,
                             width: issues.intrinsicContentSize.width,
                             height: issues.intrinsicContentSize.height)
    }
    func addSubviews(){
        view.addSubview(repoName)
        view.addSubview(repoImageView)
        view.addSubview(repoFullName)
        view.addSubview(repoLanguage)
        view.addSubview(stars)
        view.addSubview(watchers)
        view.addSubview(forks)
        view.addSubview(issues)
    }
    func setContent(){
        let fullName = repo.full_name
        let parts = fullName.split(separator: "/")
        let trimmedName = String( parts.first ?? "")
        repoName.text = trimmedName
        repoImageView.image = repoImage
        repoFullName.text = fullName
        if let language = repo.language{
            repoLanguage.text = "Written in " + language
        }else{
            repoLanguage.text = "I don't know this language"
        }
        stars.text = String(repo.stargazers_count) + " stars"
        watchers.text = String(repo.watchers_count) + " watchers"
        forks.text = String(repo.fork) + " forks"
        issues.text = String(repo.open_issues_count) + " issues"
        
        
        
        
    }


}
