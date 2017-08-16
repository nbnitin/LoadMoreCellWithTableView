//
//  TableViewController.swift
//  LoadMoreTableView
//
//  Created by Nitin Bhatia on 16/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var mainData = [String]()
    var data = [String]()
    
    var index = 0
    
    var spinner = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...100{
            mainData.append("hello \(i)")
        }
        
      spinner =  UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        createData()
        
    }
    
    func createData(){
        if(index >= mainData.count - 1){
            return
        }
        for i in index...(index+10){
            data.append(mainData[i])
        }
        
      // print(data)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            
            
            //intentially did below code to show loading indicator
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                print("done")
                self.index = self.index + 11

                self.createData()
                
                
                
                self.tableView.reloadData()
                
                self.spinner.stopAnimating()
                
            })

            
          
            
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            spinner.startAnimating()
            
            
            spinner.hidesWhenStopped = true
        }
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        
        cell.textLabel?.text = data[indexPath.row]

        // Configure the cell...

        return cell
    }
    

   

}
