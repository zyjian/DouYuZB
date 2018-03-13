//
//  HeaderReusableView.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var recommdendModel:RecommendModel? {
        didSet{
            titleLab.text = recommdendModel?.tag_name
            imgView.image = UIImage.init(named: recommdendModel?.icon_name ?? "home_header_normal")
            
        }
    }
    
    
}
