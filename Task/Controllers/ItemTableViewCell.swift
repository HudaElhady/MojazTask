//
//  ItemTableViewCell.swift
//  Task
//
//  Created by MIS on 5/4/18.
//  Copyright © 2018 Huda Elhady. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {
    
    
    //MARK: - Outlets
    @IBOutlet weak var itemPhotoImageView: UIImageView!
    @IBOutlet weak var selectItemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumIdLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    func configureCellWith(ItemData : PhotoItem , isSelected : Bool = false , isFiltering : Bool = false) {
        if let photoUrl = URL(string: ItemData.thumbnailUrl) //ItemData.thumbnailUrl
        {
            itemPhotoImageView.sd_setImage(with: photoUrl, completed: nil)
        }
        titleLabel.text = ItemData.title
        albumIdLabel.text = "\(ItemData.albumId ?? 0)"
        if isFiltering {
            selectItemImageView.isHidden = true
        }else{
            selectItemImageView.image = isSelected ? #imageLiteral(resourceName: "select") : #imageLiteral(resourceName: "Unselect")
        }
    }
    
    func setStyle()
    {
        itemPhotoImageView.layer.cornerRadius = 7
    }
    
    func getCellSelected(toSelect : Bool)  {
        if toSelect {
            selectItemImageView.image = #imageLiteral(resourceName: "select")
        }else{
            selectItemImageView.image = #imageLiteral(resourceName: "Unselect")
        }
    }
    
}
