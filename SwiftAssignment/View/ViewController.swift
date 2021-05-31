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
        setUpRefreshcontrol()
        
        // Setup for reloadTableViewClosure
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
                self?.navigationItem.title = self?.viewModel.title
            }
        }
        
    }
        override func viewWillLayoutSubviews() {
            setupAutoLayout()
            tblView.reloadData()
        }
        
        
        func setUpRefreshcontrol() {
            //Add pull to refresh:
            refreshControl = UIRefreshControl()
            refreshControl?.tintColor = UIColor.gray
            refreshControl?.attributedTitle = NSAttributedString(string: "Updating data")
            if let aControl = refreshControl {
                tblView?.addSubview(aControl)
            }
            refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        }
        
        @objc func refreshData() {
            viewModel.fetchData()
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
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell:MyCustomCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as? MyCustomCell {
            let rowData = viewModel.getData(at: indexPath)
            
            cell.rowData = rowData
            cell.setImage(url: rowData.imageHref ?? "")
            return cell
        } else {
            let  cell = MyCustomCell(style: .default,
                                     reuseIdentifier: "cell")
            let rowData = viewModel.getData(at: indexPath)
            
            cell.rowData = rowData
            cell.setImage(url: rowData.imageHref ?? "")
            return cell
        }
    }
}


