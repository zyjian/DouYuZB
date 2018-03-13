//
//  PageVC.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/8.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(source sourceIndex: Int, target targetIndex: Int, process processNum:CGFloat)
}

private let ContentCellID = "ContentCellID"
class PageContentView: UIView {
    
    //MARK:-添加属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var beganOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    private var isForbidScrollDelegate:Bool = false

    private lazy var mycollectionView : UICollectionView = { [weak self] in
        //1.创建layou
        let layou = UICollectionViewFlowLayout()
        layou.itemSize = (self?.bounds.size)!
        layou.minimumLineSpacing = 0
        layou.minimumInteritemSpacing = 0
        layou.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        var collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layou)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVcs: [UIViewController] ,parentViewController: UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)

        //设置UI
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI界面
extension PageContentView {
    private func makeUI() {
        
        //1.将所有的子控件添加到父控制器中
        for childVc in self.childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView
        addSubview(mycollectionView)
        mycollectionView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
}


// MARK: - UICollectionView 代理方法
extension PageContentView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let view = childVcs[indexPath.item].view!
        view.frame = cell.bounds
        
        cell.contentView.addSubview(view)
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beganOffsetX = scrollView.contentOffset.x
        isForbidScrollDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate { return }
        
        let nowOffsetX : CGFloat = scrollView.contentOffset.x
        
        
        var soureceIndex : Int
        var targetIndex :Int
        var process : CGFloat
        //左滑
        if nowOffsetX > beganOffsetX {
            
            //1.确定process
            process = (nowOffsetX/scrollView.frame.width - CGFloat((floor(nowOffsetX/scrollView.frame.width))))

            
            //2. 确定 soureceIndex,
            soureceIndex = Int(nowOffsetX/scrollView.frame.width)
            
            //3.确定  targetIndex
            targetIndex = soureceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //4.完全划过去
            if nowOffsetX - beganOffsetX == scrollView.frame.width {
                process = 1
                targetIndex = soureceIndex
            }
           
            
        }else{
            //右滑
            
            //1.确定process
            process = 1 - (nowOffsetX/scrollView.frame.width - CGFloat((floor(nowOffsetX/scrollView.frame.width))))

            //2.确定  targetIndex
            targetIndex = Int(nowOffsetX/scrollView.frame.width)
            
            //3. 确定 soureceIndex,
            soureceIndex = targetIndex + 1
            
            //4.完全划过去
            if soureceIndex >= childVcs.count {
                process = 1
                soureceIndex = targetIndex
            }
            
            
            
        }
        Log("soureceIndex:\(soureceIndex) ,targetIndex:\(targetIndex) process:\(process)")
        delegate?.pageContentView(source: soureceIndex, target: targetIndex, process: process)
    }
    
    
    
}


// MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex :Int)  {
        isForbidScrollDelegate = true
        
        let offsetX : CGFloat = CGFloat(currentIndex) * self.frame.width
        mycollectionView.setContentOffset(CGPoint.init(x: offsetX, y:0 ), animated: false)
    }
}










