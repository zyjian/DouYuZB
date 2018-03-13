//
//  NormalCVC.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCVC: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var roomNameLab: UILabel!
    @IBOutlet weak var nickNameLab: UILabel!
    @IBOutlet weak var perpleCountLab: UIButton!
    var roomModel:RoomModel? {
        didSet {
            guard let iconURL = roomModel?.vertical_src else { return }
            let url = URL(string: iconURL)
            self.imgView.kf.setImage(with: url)
            
            self.roomNameLab.text = roomModel?.room_name
            self.nickNameLab.text = roomModel?.nickname
            
            var countStr:String
            let count:Int = roomModel?.online ?? 0
            if count > 10000 {
                countStr = String.init(format: "%.2f", CGFloat(count)/10000)
            }else{
                countStr = "\(count)在线"
            }
            
            self.perpleCountLab.setTitle(countStr, for: .normal)
            
        }
    }
    
}
