//
//  RecommendVC.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kNormalItemW = (kScreenW - kItemMargin * 3)/2
private let kNormalItemH = kNormalItemW * 3 / 4
private let kPrettyItemH = kNormalItemW * 4 / 3

private let kHeaderH : CGFloat = 50
private let kNormalCellID = "NormalCVC"
private let kHeaderViewID = "HeaderReusableView"
private let kPrettyCVCID = "PrettyCVC"
private let kCycleH:CGFloat = 3/8 * kScreenW
private let kRecommendViewH:CGFloat = 90

class RecommendVC: UIViewController {
    
    private lazy var recommendVM : RecommendVM = RecommendVM()

    private lazy var collectionView: UICollectionView = { [ unowned self ] in
        let layou = UICollectionViewFlowLayout()
        layou.itemSize = CGSize.init(width: kNormalItemW, height: kNormalItemH)
        layou.minimumLineSpacing = 0
        layou.minimumInteritemSpacing = kItemMargin
        layou.scrollDirection = .vertical
        layou.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: kHeaderH)
        layou.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collcectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layou)
        collcectionView.delegate = self
        collcectionView.dataSource = self
        
        collcectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collcectionView.register(UINib.init(nibName: kNormalCellID, bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collcectionView.register(UINib.init(nibName: kPrettyCVCID, bundle: nil), forCellWithReuseIdentifier: kPrettyCVCID)
        
        collcectionView.register(UINib.init(nibName: kHeaderViewID, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collcectionView.backgroundColor = UIColor.white
        return collcectionView
    }()
    
    private lazy var cycleView:CycleView = {
        let cycleView = CycleView.cycleView()
        cycleView.frame = CGRect.init(x: 0, y: -(kCycleH+kRecommendViewH), width: kScreenW, height: kCycleH)
        return cycleView
    }()
    
    private lazy var recommendView:RecommendView = {
        let recommendView = RecommendView.recommendView()
        recommendView.frame = CGRect.init(x: 0, y: -kRecommendViewH, width: kScreenW, height: kRecommendViewH)

        return recommendView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        makeUI()
        recommendVM.requestData(callBack: {
            self.collectionView.reloadData()
        })
        
        recommendVM.requestCycleData(callBack: {
            self.cycleView.modelArray = self.recommendVM.cycleArray
        })
        
        recommendVM.requestGameData {
            self.recommendView.gameArray = self.recommendVM.gameArray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}

extension RecommendVC {
    func makeUI() {
        self.view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.contentInset = UIEdgeInsets.init(top: kCycleH+kRecommendViewH, left: 0, bottom: 0, right: 0 )
        collectionView.addSubview(recommendView)


    }
}
extension RecommendVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommendVM.recommendArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let recommendModel:RecommendModel =  self.recommendVM.recommendArray[section]
        return recommendModel.room_list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let recommendModel:RecommendModel =  self.recommendVM.recommendArray[indexPath.section]

        if indexPath.section == 1 {
            let cell:PrettyCVC = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCVCID, for: indexPath) as! PrettyCVC
            cell.roomModel = recommendModel.room_list[indexPath.row]
            return cell
        }
        
        let cell:NormalCVC = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCVC
        cell.roomModel = recommendModel.room_list[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header:HeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! HeaderReusableView
        
        let recommendModel:RecommendModel =  self.recommendVM.recommendArray[indexPath.section]
        header.recommdendModel = recommendModel
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize.init(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize.init(width: kNormalItemW, height: kNormalItemH)
    }

    
    
}



