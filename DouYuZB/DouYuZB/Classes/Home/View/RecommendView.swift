//
//  RecommendView.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/13.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

class RecommendView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!

    var gameArray:[RoomModel] = [RoomModel]() {
        didSet{
           collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        
        let layou = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layou.scrollDirection = .horizontal
        
        collectionView.register(UINib.init(nibName: "RecommendCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendCVC")
    }
}

extension RecommendView {
    class func recommendView() -> RecommendView {
        return Bundle.main.loadNibNamed("RecommendView", owner: nil, options: nil)?.first as! RecommendView
    }
}

extension RecommendView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RecommendCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCVC", for: indexPath) as! RecommendCVC
        let model = self.gameArray[indexPath.item]
        cell.model = model
        return cell
    }
}






