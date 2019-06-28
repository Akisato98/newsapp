//
//  Page1ViewController.swift
//  newsApp
//
//  Created by Akiko Sato on 2019/06/13.
//  Copyright © 2019 Akiko Sato. All rights reserved.
//

import UIKit
import SegementSlide

class Page5ViewController: UITableViewController, SegementSlideContentScrollViewDelegate, XMLParserDelegate {
    
    //XMLParserDelegateのインスタンス作る
    var parser = XMLParser()
    var newsItems = [NewsItems]()
    //RSSのパースの中の現在の要素の名前
    var currentElementName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        //コードで背景の画像貼る
        let image = UIImage(named: "4.jpg")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        imageView.image = image
        self.tableView.backgroundView = imageView
        // Do any additional setup after loading the view.
        
        //yahoo!のRSS(hxxtps://headlines.yahoo.co.jp/rss/list)貼る
        //なぜかRSS読まない。。
        let urlString: String = "https://headlines.yahoo.co.jp/rss/wired-all.xml"
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
        cell.textLabel?.numberOfLines = 3
        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white
        return cell
    }
    
    @objc var scrollView: UIScrollView {
        return tableView
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item" {
            self.newsItems.append(NewsItems())
        } else {
            currentElementName = elementName
        }
    }
    
    //func parser(XMLParser, foundCharacters: String)...> 現在の要素の文字の全部または一部を表す文字列をデリゲートに提供するために、パーサーオブジェクトによって送信される。
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0 {
            //記事を表示(タイトル、URL、日付PubDate)とか
            //上で0以上にしてるので、-1にしないと0番目から数えられない
            let lastItem = self.newsItems[self.newsItems.count - 1]
            if string.elementsEqual("\n") {
                return                
            }
            switch self.currentElementName {
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "PubDate":
                lastItem.pubDate = string
                print(lastItem.pubDate as Any)
            default:break
            }
        }
    }
    
    //didEndElement書く
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI newspaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //WebViewに画面遷移した先で取得したURL表示したいのでWebViewController作る
        let webViewController: UIViewController = WebViewController()
        //WebViewControllerに遷移
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row]
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        
        self.present(webViewController, animated: true, completion: nil)
    }
    
}

