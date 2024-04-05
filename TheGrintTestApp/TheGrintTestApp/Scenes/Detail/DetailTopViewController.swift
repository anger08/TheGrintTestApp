//
//  DetailTopViewController.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import UIKit

class DetailTopViewController: BaseViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTopHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var detailDt: TopChildren?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        settingsNavBarImage()
        getDetailDta(reddit: detailDt)
    }

    func getDetailDta(reddit: TopChildren?) {
        if reddit?.data.media?.oembed?.thumbnailUrl != nil {
            detailImageView.setImage(urlString: reddit?.data.media?.oembed?.thumbnailUrl)
        } else {
            imageHeightConstraint.constant = 1
            titleTopHeightConstraint.constant = 90
        }

        titleLabel.text = reddit?.data.title
        if reddit?.data.numComments ?? 0 >= 2 {
            commentsLabel.text = "Comentarios: \(reddit?.data.numComments ?? 0)"
        } else {
            commentsLabel.text = "Comentario: \(reddit?.data.numComments ?? 0)"
        }

        usernameLabel.text = reddit?.data.author
    }
}
