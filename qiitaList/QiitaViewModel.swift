//
//  QiitaViewModel.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit
let CellId = "CellId"

class QiitaViewModel: NSObject,UITableViewDelegate, UITableViewDataSource  {
    var qiitList: [AnyObject] = []
    private var mRequestTask: NSURLSessionDataTask?
    override init() {
        super.init()
    }
    
    func updateQiitaList(complated:() -> Void) {
        qiitList = []

        var request = NSMutableURLRequest(URL: NSURL(string: "https://qiita.com/api/v2/items")!)
        request.HTTPMethod = "GET"
        mRequestTask?.cancel();
        mRequestTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            if (error == nil) {
                var error:NSErrorPointer = NSErrorPointer()
                var originList = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: error) as? [[String:AnyObject]]
                
                for origin in originList!{
                    self.qiitList.append(origin["title"] as! String)
                }
            } else {
                println(error)
            }
            complated()
        })
        mRequestTask!.resume()
    }
    
    
    // MARK: - DataSourceメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellId);
        cell.textLabel?.text = qiitList[indexPath.row] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitList.count ?? 0;
    }
}
