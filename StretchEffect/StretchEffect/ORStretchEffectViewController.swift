//
//  ORStretchEffectViewController.swift
//  StretchEffect
//
//  Created by sunrise on 16/10/12.
//  Copyright © 2016年 OYR. All rights reserved.
//

import UIKit

import UIKit

let headImageViewHeight:CGFloat = 250.0 * Tool.kHeight / 736.0

class ORStretchEffectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    lazy var headImageView :UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Tool.kWidth, height: headImageViewHeight))
        imageView.image = UIImage(named: "1.jpg")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var tableView :UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: Tool.kWidth, height: Tool.kHeight - 64))
        //the key of this effict
        tableView.contentInset = UIEdgeInsetsMake(headImageViewHeight - 64, 0, 0, 0)
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var blurEffect:UIVisualEffectView = {
        let blur = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        let effectView = UIVisualEffectView.init(effect: blur)
        effectView.alpha = 0
        
        return effectView;
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUserInterface()
    }
    
    func initUserInterface() {
        
        self.title = "Biautiful"
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.boldSystemFont(ofSize: 20)];
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        //        self.navigationController?.navigationBar.barTintColor = UIColor.init(white: 0.3, alpha: 0.7)
        
        self.blurEffect.frame = self.headImageView.bounds
        self.headImageView.addSubview(self.blurEffect)
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.red
        self.view.addSubview(self.headImageView)
        self.view.addSubview(self.tableView )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "my test demo"
        cell?.detailTextLabel?.text = "swift - 09.14"
        return cell!;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let alpha = 1 + scrollView.contentOffset.y / (headImageViewHeight-64)
        self.blurEffect.alpha = alpha
        
        
        
        if scrollView.contentOffset.y <= -headImageViewHeight + 64 {
            
            
            self.headImageView.bounds.size.height =  -scrollView.contentOffset.y + 64
            
            //This code can solve a serious bug
            self.headImageView.frame.origin.y = 0
        }
        
        
        
        
    }
    
    
    
}
