//
//  HomeCollectionViewCell.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subtitleDescription: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    static let reuseIdentifier = "TopViewCell"
    static let cellHeight: CGFloat = 600

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 3
    }

    func configUI(top: TopChildren) {
        descriptionLabel.text = top.data.title

        let maxCharacters = 100
          let title = top.data.title
          if title.count > maxCharacters {
              descriptionLabel.text = String(title.prefix(maxCharacters)) + "..."
          } else {
              descriptionLabel.text = title
          }
        authorLabel.text = top.data.author
        commentsLabel.text =  "\(top.data.numComments)"
        subtitleDescription.text = "\(top.data.subreddit)"

        if let image = top.data.media?.oembed?.thumbnailUrl  {
            pictureImageView.setImage(urlString: image)
        }
    }

}
