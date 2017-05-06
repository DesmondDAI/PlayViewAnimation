//
//  FeatureListTableViewController.swift
//  ViewAnimation
//
//  Created by DAIXinming on 02/05/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class FeatureListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "UIViewPropertyAnimator交互式动画"
            
        case 1:
            cell.textLabel?.text = "UIKit Dynamics交互式动画"
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: Constants.SegueID.listToViewPropertyAnimatorVC, sender: self)
            
        case 1:
            performSegue(withIdentifier: Constants.SegueID.listToDynamicUpDownCardVC, sender: self)
            
        default:
            break
        }
    }
}
