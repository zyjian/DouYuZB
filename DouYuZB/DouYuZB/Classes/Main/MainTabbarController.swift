//
//  MainTabbarController.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/7.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChile(name: "Home")
        addChile(name: "Live")
        addChile(name: "Follow")
        addChile(name: "Mine")
    }
    
    func addChile(name:String) {
        let childVC = UIStoryboard.init(name: name, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
