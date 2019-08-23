//
//  ViewController.swift
//  DevEvaluationProject
//
//  Created by user on 8/14/19.
//  Copyright © 2019 Azarenkov Serhii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    private let model = Model()
  
    private let footerActivityView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        view.backgroundColor = .lightGray
        let indicator =   UIActivityIndicatorView(style: .whiteLarge)
        indicator.backgroundColor = .lightGray
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.center = view.center
        return view
    }()
    
    private let footerEndListView: UIView = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        label.textAlignment = .center
        label.text = "There's no more hits for now"
        label.font = UIFont(name: "System", size: 10)
        label.textColor = .gray
        return label
    }()
    
    
    //MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    //MARK: View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.loadMore()
        
    }

    //MARK: Methods
    
    func showListEnd(){
        self.tableView.tableFooterView = footerEndListView
        self.tableView.tableFooterView?.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.tableFooterView?.isHidden = true
            
        }
    }

    func setupView(){
        navigationItem.title = "No posts"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 20
        self.tableView.tableFooterView = footerActivityView
    }
}

//MARK: - TableViewDelegate, TableViewDatasource

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Consts.CellIdentifiers.cell.rawValue, for: indexPath)
        
        let item = model.getItemForRow(row: indexPath.row)
        cell.textLabel?.text = item.postTitle
        cell.detailTextLabel?.text = item.createdAt
        
        
        guard let isContainItem = tableView.indexPathsForVisibleRows?.contains(indexPath) else { return cell }
        if isContainItem == true, indexPath.row >= model.getItemsCount() - 1{
            loadMore()
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
 
}

//MARK: - Loading new content

private extension ViewController{
    
    
    func loadMore(){
        tableView.tableFooterView?.isHidden = false
        model.loadMore { [weak self](error, isListEnded) in
            self?.processCallback(error: error, isListEnded: isListEnded)
        }
       
        
    }
    
    func processCallback(error: String?, isListEnded: Bool){
        tableView.tableFooterView?.isHidden = true
        if let error = error{
            showAlert(message: error)
            return
        }
        if isListEnded{
            showListEnd()
            return
        }
        navigationItem.title = "Posts: \(model.getItemsCount())"
        tableView.reloadData()
    }
    
}




