//
//  RepoTableViewCell.swift
//  GoonsDesignInterview
//
//  Created by TC Lee on 2023/10/26.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    static let identifier = "RepoTableViewCellIdentifier"
    
    var repo: Repo!
    
    var repoImage : UIImageView!
    var repoTitle : UILabel!
    var repoDescription : UILabel!
    var textContainer: UIView!
    
    let iconSize : CGFloat = 60
    let cellPadding :CGFloat = 5

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        repoImage = UIImageView()
        repoImage.clipsToBounds = true
        repoImage.contentMode = .scaleAspectFill
        repoImage.layer.cornerRadius = iconSize/2
        contentView.addSubview(repoImage)

        textContainer = UIView()
        contentView.addSubview(textContainer)
        
        
        repoTitle = UILabel()
        repoTitle.font = UIFont.boldSystemFont(ofSize: 19)
        textContainer.addSubview(repoTitle)
        
        //User Account
        repoDescription = UILabel()
        repoDescription.font = UIFont.systemFont(ofSize: 13)
        repoDescription.numberOfLines = 2
        textContainer.addSubview(repoDescription)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentPadding:CGFloat = 6
        
        repoImage.frame = CGRect(x: contentView.left + cellPadding,
                                 y: (contentView.height - iconSize) / 2 ,
                                 width: iconSize,
                                 height: iconSize)
        
        let textContainerSize = CGSize(width: contentView.width - repoImage.right - contentPadding * 3, height: contentView.height)

        textContainer.frame = CGRect(x: repoImage.right + contentPadding,
                                     y: (contentView.height - textContainer.height)/2,
                                     width: textContainerSize.width,
                                     height: textContainerSize.height)
        let titleLabelSize = repoTitle.sizeThatFits(CGSize(width: textContainerSize.width, height: .greatestFiniteMagnitude))
        let descriptionLabelSize = repoDescription.sizeThatFits(
            CGSize(width: textContainerSize.width,
                   height: .greatestFiniteMagnitude))
        
        repoTitle.frame = CGRect(origin: CGPoint(x: contentPadding, y: contentPadding),
                                 size: titleLabelSize)
        
        repoDescription.frame = CGRect(origin: CGPoint(x: contentPadding, y: repoTitle.bottom + contentPadding),
                                       size: descriptionLabelSize)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        repoTitle.text = ""
        repoImage.image = nil
        repoDescription.text = ""
    }

}
