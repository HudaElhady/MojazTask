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
    @IBOutlet weak var noDataLabel: UILabel!
    
    //MARK: - Variables & Properties
    var pageNumber = 0
    var photosArr = [PhotoItem]()
    var selectedPhotosIds = [Int]()
    var loadMore = true
    var isFiltering = false
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setStyle()
        getPhotosList()
    }
    
    
    @IBAction func doneButtonHandler(_ sender: UIButton) {
        if selectedPhotosIds.count > 0
        {
            isFiltering = true
            navigationItem.title = "Filtered"
            DoneButton.isHidden = true
            tableView.reloadData()
        }
    }
    
    //MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isFiltering ? selectedPhotosIds.count : photosArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        if isFiltering
        {
            let item = photosArr.first(where: { (x) -> Bool in
                 return x.id == selectedPhotosIds[indexPath.row]
            })
            if item != nil
            {
                cell.configureCellWith(ItemData: photosArr[indexPath.row],isSelected: false,isFiltering: true)
            }
        }else{
           // let isItemSelected = false
            let isItemSelected = selectedPhotosIds.contains(photosArr[indexPath.row].id) ? true : false
            if isItemSelected
            {
                print("\(photosArr[indexPath.row].id ?? 0)")
            }
             cell.configureCellWith(ItemData: photosArr[indexPath.row],isSelected: isItemSelected)
        }
       
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if loadMore , indexPath.row == photosArr.count - 2
        {
            getPhotosList()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isFiltering
        {
            if let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell
            {
                let itemId = photosArr[indexPath.row].id
                if let index = selectedPhotosIds.index(of: itemId!)
                {
                    selectedPhotosIds.remove(at: index)
                    cell.getCellSelected(toSelect: false)
                }else{
                    selectedPhotosIds.append(itemId!)
                    cell.getCellSelected(toSelect: true)
                }
            }
        }
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
    
    func startLoading(){
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        view.addSubview(activityIndicator);
        activityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
        
    }
    
    func stopLoading(){
        
        activityIndicator.stopAnimating();
        UIApplication.shared.endIgnoringInteractionEvents();
        
    }
    
    //MARK: Get Photos
    func getPhotosList() {
        startLoading()
        let serverManager = ServerManager()
        serverManager.getPhotosList(pageNumber: pageNumber*10, pageSize: 10)
        serverManager.didFinish = {
            json in
            self.stopLoading()
            if let jsonObj = json as? [PhotoItem]
            {
                if jsonObj.count > 0
                {
                    print(self.pageNumber)
                    self.pageNumber += 1
                    self.loadMore = true
                    self.photosArr.append(contentsOf: jsonObj)
                    self.tableView.reloadData()
                    
                }else
                {
                    self.loadMore = false
                    if self.pageNumber == 0
                    {
                        self.noDataLabel.text = "There is no Photos"
                    }
                }
            }
        }
        serverManager.didFinishWithError =
            { error, msg in
                self.stopLoading()
                if self.pageNumber == 0
                {
                if error == ErrorCode.NoInternet
                {
                    self.noDataLabel.text = "There is no internet connection"
                }else{
                    self.noDataLabel.text = "Something went wrong"
                }
                }
        }
    }
    
    
}

