//
//  ViewController.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    private var tblView: UITableView!
    private var refreshControl: UIRefreshControl?
    private var reachability: NetworkReachabilityManager!
    private var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = DataViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reachability = NetworkReachabilityManager.default
        monitorReachability()
        setupUI()
        setUpRefreshcontrol()
        
        // Setup for reloadTableViewClosure
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
                self?.navigationItem.title = self?.viewModel.title
            }
        }
        // Setup for updateLoadingStatusClosure
        updateLoadingStatus()
    }
    override func viewWillLayoutSubviews() {
        setupAutoLayout()
        tblView.reloadData()
    }
    
    func updateLoadingStatus(){
        viewModel.updateLoadingStatusClosure = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tblView.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.refreshControl?.endRefreshing()
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tblView.alpha = 1.0
                    })
                }
            }
        }
    }
    
    func setUpRefreshcontrol() {
        //Add pull to refresh:
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = themeSubtitleColor
        if let aControl = refreshControl {
            tblView?.addSubview(aControl)
        }
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    @objc func loadData() {
        if(isConnected()){
            viewModel.fetchData()
            refreshControl?.attributedTitle = NSAttributedString(string: "Updating data")
        }
        else {
            notReachableSetUp()
        }
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
    
    // SHOW THE ALERT WHEN HOST IS NOT REACHABLE
    func notReachableSetUp() {
        if let isRefreshing = refreshControl?.isRefreshing {
            if (isRefreshing) {
                refreshControl?.endRefreshing()
            }
        }
        activityIndicator?.stopAnimating()
        DispatchQueue.main.async {
            self.tblView.reloadData()
            self.showAlert(withTitle: alertTitle, andMessage: alertMessage)
            self.refreshControl?.attributedTitle = NSAttributedString(string: "No Internet")
        }
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = themeTitleColor
        return headerView
    }
}

extension ViewController {
    
    // ALERT METHOD
    func showAlert(withTitle title: String?, andMessage message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    // MARK: - Private - Reachability
    private func monitorReachability() {
        reachability?.startListening { status in
            print("Reachability Status Changed: \(status)")
            self.loadData()
        }
    }
    
    private func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

