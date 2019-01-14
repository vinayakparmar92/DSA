//
//  ViewController.swift
//  DSAPractise
//
//  Created by Vinayak Parmar on 18/10/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var btnTemp: UIButton!
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "TMPTVC",
                                      bundle: nil),
                           forCellReuseIdentifier: "temp")
        
        let queue1 = DispatchQueue.global()
        let queue2 = DispatchQueue.global()
        let queue3 = DispatchQueue.main
        let queue4 = DispatchQueue.global()
        let queue9 = DispatchQueue.global(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.default,
                                                           relativePriority: 100).qosClass)
        let queue10 = DispatchQueue.global(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.default,
                                                           relativePriority: 10).qosClass)
        let queue5 = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        let queue6 = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let queue7 = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
        let queue8 = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temp",
                                                 for: indexPath)
        if cell.textLabel?.text == nil {
            cell.textLabel?.text = "ROW  \(indexPath.row)"
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            print(scrollView.bounds)
            print(scrollView.frame)
            print(scrollView.contentOffset)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row % 10 < 2 {
//            return 10
//        }
//
//        if indexPath.row % 10 > 8 {
//            return 20
//        }
        
        return 80
    }
}
