//
//  ViewController.swift
//  Task
//
//  Created by MIS on 5/4/18.
//  Copyright © 2018 Huda Elhady. All rights reserved.
//

import UIKit

class PhotosListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setStyle()
    }
    
    //MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        return cell
    }
    
     //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Style
    func setStyle() {
        DoneButton.layer.cornerRadius = 17
        DoneButton.layer.shadowColor = UIColor.purple.cgColor
        DoneButton.layer.shadowOpacity = 0.5
        DoneButton.layer.shadowOffset = CGSize.zero
        DoneButton.layer.shadowRadius = 3
        DoneButton.layer.masksToBounds = false
    }
    
    
}

