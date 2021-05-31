//
//  ViewController.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import UIKit

class ViewController: UIViewController {
    private var tblView: UITableView!
    private var refreshControl: UIRefreshControl?
    private var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = DataViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        
    }
    
    override func viewWillLayoutSubviews() {
        setupAutoLayout()
        tblView.reloadData()
    }    
    
    // Setting up the View User Interface
    func setupUI() {
        let barHeight:CGFloat
        if #available(iOS 13.0, *) {
            barHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            barHeight = UIApplication.shared.statusBarFrame.height
        }
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        tblView = UITableView(frame: CGRect(x: 0, y: barHeight + 44, width: displayWidth, height: displayHeight - barHeight))
        tblView.register(MyCustomCell.self, forCellReuseIdentifier: "cell")
        tblView.dataSource = self
        tblView.delegate = self
        view.addSubview(tblView)
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 44.0
        tblView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        activityIndicator = UIActivityIndicatorView.init(frame: CGRect(x: displayWidth/2 - 15, y: displayHeight/2 - 15, width: 30, height: 30))
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    
    // Setting up the tableview Constraints
    func setupAutoLayout() {
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tblView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tblView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tblView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - TableView - DataSource and Delegates

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyCustomCell = (self.tblView.dequeueReusableCell(withIdentifier: "cell") as? MyCustomCell)!
                    return cell
    }
    
}


