//
//  ViewController.swift
//  QiitaApps
//
//  Created by Ryuya Tosaka on 2017/08/15.
//  Copyright © 2017年 ryuya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // itemsをJSONの配列と定義
    var items: [JSON] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TableViewを作成
        tableView.frame = CGRect(x: 0, y: 61, width: self.view.frame.width, height: self.view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        // QiitaのAPIからデータを取得
        let listUrl = "http://qiita-stock.info/api.json";
        Alamofire.request(listUrl).responseJSON{ response in
            let json = JSON(response.result.value ?? 0)
            json.forEach{(_, data) in
                self.items.append(data)
            }
            self.tableView.reloadData()
        }
        
    }
    
    // tableのcellにAPIから受け取ったデータを入れる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableCell")
        cell.textLabel?.text = items[indexPath.row]["title"].string
        cell.detailTextLabel?.text = "投稿日 : \(items[indexPath.row]["send_date"].stringValue)"
        return cell
        
    }
    
    // cellの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    // cellが選択された際に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(items[indexPath.row]["title"])
    
    }

    @IBAction func refresh(_ sender: Any) {
        
        tableView.reloadData()
        print("更新ボタンが押されたよ")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

