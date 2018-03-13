//
//  PrettyCVC.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

class PrettyCVC: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var roomNameLab: UILabel!
    @IBOutlet weak var cityLab: UILabel!
    
    @IBOutlet weak var peopleCountLab: UILabel!
    
    var roomModel:RoomModel? {
        didSet{
            guard let iconURL = roomModel?.vertical_src else {
                return
            }
            self.imgView.kf.setImage(with: URL.init(string: iconURL))
            self.roomNameLab.text = roomModel?.room_name
            self.cityLab.text = roomModel?.anchor_city
            
            
            var countStr:String
            let count:Int = roomModel?.online ?? 0
            if count > 10000 {
                countStr = String.init(format: "%.2f", CGFloat(count)/10000)
            }else{
                countStr = "\(count)在线"
            }
            self.peopleCountLab.text = countStr
        }
    }
    
    
}
