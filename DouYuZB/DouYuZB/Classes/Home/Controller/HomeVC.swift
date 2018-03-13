//
//  HomeVC.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/7.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

private let kPageTitleH:CGFloat = 40

class HomeVC: UIViewController {
    
    //MARK:-懒加载属性
    private lazy var pageTitleView :PageTitleView = { [ weak self ] in
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView.init(frame: CGRect.init(x: 0, y: kStateH+kNavgitionH, width: kScreenW, height: kPageTitleH), titles: titles)
        titleView.delegate = self
        
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [ weak self] in
        let pageFrame : CGRect = CGRect.init(x: 0, y: kNavAndStateH + kPageTitleH, width: view.frame.width, height: kScreenH - kNavAndStateH - kTabBarH)
        
        var childVCs = [UIViewController]()
        
        var vc = RecommendVC()
        childVCs.append(vc)
        
        for i in 0..<3 {
            let vc = UIViewController()
            
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), a: 1)
            childVCs.append(vc)
        }
        
        let pageContentView = PageContentView.init(frame: pageFrame, childVcs: childVCs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
        //1.设置UI界面
        setupUI()
        
        //2.添加titleView
        view.addSubview(pageTitleView)
        
        //3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK:-------设置UI界面
extension HomeVC {
    private func setupUI() {
        //0.不要调整scrollview 的内边距
        automaticallyAdjustsScrollViewInsets = false

        //1.设置导航栏
        setupNavigationBar()
        
    }
    
    private func setupNavigationBar() {
        //1.左侧导航

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        let size = CGSize.init(width: 40, height: 40)
        let scanItem = UIBarButtonItem.init(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        let my_historyItem = UIBarButtonItem.init(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)

        //2.右侧导航
        navigationItem.rightBarButtonItems = [scanItem,searchItem,my_historyItem]
    }
    
}


// MARK: - PageTitleViewDelegate 代理犯法
extension HomeVC : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, seletedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeVC : PageContentViewDelegate {
    func pageContentView(source sourceIndex: Int, target targetIndex: Int, process processNum: CGFloat) {
        
        pageTitleView.setCurrentIndex(sourceIndex: sourceIndex, targetIndex: targetIndex, process: processNum)
    }
}






