//
//  MainTableViewController.swift
//  TweenApp
//
//  Created by RF on 08/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? TitleIconTableViewCell {
            cell.animateIn()
        }
    }
}
