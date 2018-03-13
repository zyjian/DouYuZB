//
//  CycleCVC.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/12.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

class CycleCVC: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var model:CycleModel? {
        didSet{
            imgView.kf.setImage(with: URL.init(string: (model?.pic_url)!))
            titleLab.text = model?.title
        }
    }

}
