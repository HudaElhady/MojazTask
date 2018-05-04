//
//  ItemTableViewCell.swift
//  Task
//
//  Created by MIS on 5/4/18.
//  Copyright © 2018 Huda Elhady. All rights reserved.
//

import UIKit

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
    
    func configureCellWith() {
        
    }
    func setStyle()
    {
        itemPhotoImageView.layer.cornerRadius = 7
    }
    
    
}
