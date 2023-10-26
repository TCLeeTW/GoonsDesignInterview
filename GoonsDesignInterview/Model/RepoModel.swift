//
//  RepoModel.swift
//  GoonsDesignInterview
//
//  Created by TC Lee on 2023/10/26.
//

import Foundation
struct GitHubGetResult:Codable{
    let items:[Repo]
}
struct Repo:Codable{
    // List: Icon, Name, Description
    // Detail: Repository name、owner icon、Program language、stars、Watcher、Fork、Issue
    let name:String
    let full_name:String
    let description:String?
    let owner:Owner
    let language:String?
    let watchers_count:Int
    let stargazers_count:Int
    let fork:Bool
    let open_issues_count:Int
}

struct Owner:Codable{
    let login:String
    let avatar_url:String
}
