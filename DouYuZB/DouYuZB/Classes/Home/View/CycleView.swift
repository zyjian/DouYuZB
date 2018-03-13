//
//  CycleView.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/12.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

class CycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var cycleTimer : Timer?

    
    var modelArray:[CycleModel]=[CycleModel]() {
        didSet{
            collectionView.reloadData()
            self.pageControl.numberOfPages = self.modelArray.count
            
            let indexPath = IndexPath.init(item: self.modelArray.count*100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeTime()
            addTime()
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        autoresizingMask = []
    }
    
    override func layoutSubviews() {
        collectionView.frame = self.bounds
        let layou = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layou.itemSize = CGSize.init(width: self.frame.width, height: self.bounds.height)
        collectionView.register(UINib.init(nibName: "CycleCVC", bundle: nil), forCellWithReuseIdentifier: "CycleCVC")
    }
    
}

extension CycleView {
    class func cycleView() -> CycleView {
        return Bundle.main.loadNibNamed("CycleView", owner: nil, options: nil)?.first as! CycleView
    }
    
}

extension CycleView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CycleCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "CycleCVC", for: indexPath) as! CycleCVC
        let model = self.modelArray[indexPath.item % self.modelArray.count]
        cell.model = model
        return cell
    }
    
}
extension CycleView:UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let ox = scrollView.contentOffset.x + self.frame.width * 0.5
        let index = Int(ox / self.frame.width)
        self.pageControl.currentPage = index % (modelArray.count )
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTime()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTime()
    }
}

extension CycleView{
    func addTime() {
        cycleTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timeClick), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    func removeTime() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc func timeClick(){
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

