//
//  QitaListViewController.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class QitaListViewController: UIViewController,UITableViewDelegate {
    // MARK: - ライフサイクル系
    let mModel = QiitaViewModel();
    
    override func loadView() {
        super.loadView()
        self.view = QiitaListView(frame: self.view.bounds,model:mModel);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qiitaListView = self.view as! QiitaListView
        qiitaListView.reloadBtn.addTarget(self, action: "tableUpdate:", forControlEvents: UIControlEvents.TouchUpInside)
        qiitaListView.table.delegate   = self;
        qiitaListView.table.dataSource = mModel;
    }
    
    func tableUpdate(sender:UIButton){
        let qiitaListView = self.view as! QiitaListView
        mModel.updateQiitaList { () -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                qiitaListView.table.reloadData()
            })
        }
    }
}