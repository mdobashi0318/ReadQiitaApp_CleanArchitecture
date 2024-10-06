//
//  ArticleCell.swift
//  
//
//  Created by 土橋正晴 on 2024/10/06.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var organizationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var lileCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codez
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setModel(article: ArticleListRow) {
        userNameLabel.text = article.useName.isEmpty ? article.id : article.useName
        organizationLabel.text = article.organization
        dateLabel.text = article.date
        titleLabel.text = article.title
        tagsLabel.text = article.tags
        lileCountLabel.text = article.likes
    }
    
}
