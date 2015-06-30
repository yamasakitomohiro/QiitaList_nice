//
//  QiitaListView.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class QiitaListView: UIView {
    let table :UITableView
    let reloadBtn:UIButton
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect,model: QiitaViewModel) {
        table = UITableView(frame: CGRectMake(0, 0, frame.width, frame.size.height - 50), style: UITableViewStyle.Plain);
        reloadBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
        
        
        super.init(frame: frame);
        
        reloadBtn.setTitle("更新", forState: UIControlState.Normal);
        reloadBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal);
        reloadBtn.sizeToFit();
        reloadBtn.center = CGPointMake(self.frame.width / 2,self.frame.height - 20);
        
        
        self.addSubview(table);
        self.addSubview(reloadBtn);
    }

}
