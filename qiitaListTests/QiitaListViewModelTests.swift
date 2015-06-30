//
//  QiitaListViewModelTests.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/06/22.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit
import XCTest
import OHHTTPStubs

class QiitaListViewModelTests: XCTestCase {
    let model = QiitaViewModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.absoluteString == "https://qiita.com/api/v2/items"}) { _ in
            let stubPath = OHPathForFile("response.json", self.dynamicType)
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"text/plain"]
                )
                .requestTime(1, responseTime:OHHTTPStubsDownloadSpeed3G)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        OHHTTPStubs.removeAllStubs()
        
        super.tearDown()
    }
    
    func testReloadQiitaList(){
        let qiitaApiRequestExpectation = self.expectationWithDescription("qiitaApiRequest")
        
        model.qiitList = ["ここには","適当な値をいれておく","ほほほほほほ","あああ"]
        model.updateQiitaList { () -> Void in
            XCTAssertEqual(
                self.model.qiitList as! [String],
                ["[質問] Cocoapodsで取り込んだObjective-CライブラリをSwiftから呼び出したい","MySQLのメモ"])
            qiitaApiRequestExpectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(2, handler: { (error) -> Void in
            
        })
    }
    
    func testCellForRowAtIndexPath(){        
        self.measureBlock { () -> Void in
            model.tableView(UITableView(), cellForRowAtIndexPath:  NSIndexPath(forRow: 0, inSection: 0))            
        }
    }
}
