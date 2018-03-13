//
//  RecommendCVC.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/13.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

class RecommendCVC: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model:RoomModel = RoomModel() {
        didSet{
            imgView.kf.setImage(with: URL.init(string: model.icon_url!))
            titleLab.text = model.tag_name
        }
    }
    
    
    

}
