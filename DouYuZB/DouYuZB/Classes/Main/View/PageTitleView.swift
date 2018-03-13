//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/7.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit


//MARK:- 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView:PageTitleView, seletedIndex index : Int)
}

//MARK:-定义常量
let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,120,0)

class PageTitleView: UIView {
    //MARK:-定义属性
    private var titles: [String]
    private var currentIndex:Int = 0
    weak var delegate:PageTitleViewDelegate?
    
    //懒加载
    private lazy var titleLabels:[UILabel] = [UILabel]()
    private lazy var scrollView :UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    
    //MARK:-自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:-设置UI界面
extension PageTitleView {
    private func setupUI() {
        //1.添加scrollview
        addSubview(scrollView)
        scrollView.frame =  bounds

        //2.添加对应的label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupBottomLineAndScorllLine()
        
    }
    
    private func setupTitleLabels() {
        
        //0.确定label 的一些值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            
            //1.创建label
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1)
            label.tag = index
            //3.设置label 的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.添加手势事件
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.titleClick(tap:)))
            label.addGestureRecognizer(tap)
        }
        
    }
    
    private func setupBottomLineAndScorllLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect.init(x: 0, y: frame.height-lineH, width: frame.size.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个label
        scrollView.addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.init(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, a: 1)
        
        scrollLine.frame = CGRect.init(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        

    }
}

// MARK: - 监听事件
extension PageTitleView {
    @objc func titleClick(tap:UITapGestureRecognizer ){

        //1.找的新的label
        guard let newLab = tap.view as? UILabel else { return }
        
        //2.找到原来的label
        let oldLab = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        oldLab.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1)

        newLab.textColor = UIColor.init(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, a: 1)
        
        //4.保存下标值
        currentIndex = newLab.tag
        
        //5.滚动条改变位置
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理
        delegate?.pageTitleView(titleView: self, seletedIndex: currentIndex)
        
    }
}

// MARK: - 对外暴露方法
extension PageTitleView {
    func setCurrentIndex(sourceIndex: Int, targetIndex: Int, process: CGFloat) {
        //1.取出sourceLabel targetLabel
        let sourceLabel: UILabel = titleLabels[sourceIndex]
        let targetLabel: UILabel = titleLabels[targetIndex]
        
        
        //2.改变下标值
        currentIndex = targetIndex
        
        //3.移动滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * process
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //4.颜色渐变33
        //4.1取出颜色变化范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0 , kSelectedColor.1 - kNormalColor.1 , kSelectedColor.2 - kNormalColor.2)
        //4.2变化sourceLabel
        sourceLabel.textColor = UIColor.init(r: kSelectedColor.0 - colorDelta.0*process, g: kSelectedColor.1 - colorDelta.1*process, b: kSelectedColor.2 - colorDelta.2 * process, a: 1)
        //4.3变化sourceLabel
        targetLabel.textColor = UIColor.init(r: kNormalColor.0 + colorDelta.0*process, g:kNormalColor.1 + colorDelta.1*process , b: kNormalColor.2 + colorDelta.2*process, a: 1)
        
    }
}










