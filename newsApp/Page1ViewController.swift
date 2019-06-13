//
//  Page1ViewController.swift
//  newsApp
//
//  Created by Akiko Sato on 2019/06/13.
//  Copyright © 2019 Akiko Sato. All rights reserved.
//

import UIKit
import SegementSlide

class Page1ViewController: UITableViewController, SegementSlideContentScrollViewDelegate, XMLParserDelegate {
    
    //XMLParserDelegateのインスタンス作る
    var parser = XMLParser()
    var newsItems = [NewsItems]()
    //RSSのパースの中の現在の要素の名前
    var currentElementName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        //コードで背景の画像貼る
        let image = UIImage(named: "")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        imageView.image = image
        self.tableView.backgroundView = imageView
        // Do any additional setup after loading the view.
        
        //yahoo!のRSS(hxxtps://headlines.yahoo.co.jp/rss/list)貼る
        let urlString: String = "https://news.yahoo.co.jp/pickup/rss.xml"
        let url: URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        
        //解析始める
        parser.parse()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/5
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return newsItems.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        let newsItem = self.newsItems[indexPath.row]
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item" {
            self.newsItems.append(NewsItems())
        } else {
            currentElementName = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0 {
            
        }
    }
    
    }
