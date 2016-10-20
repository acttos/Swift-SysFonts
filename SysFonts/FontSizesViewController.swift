//
//  FontSizesViewController.swift
//  SysFonts
//
//  Created by actto on 10/15/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController {

    var font:UIFont!;
    private var pointSizes:[CGFloat] = [9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144];
    private let cellIdentifier = "FontNameAndSizeCellIdentifier";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pointSizes.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath);
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath);
        cell.textLabel?.text = font.fontName;
        cell.detailTextLabel?.text = "Size:\(pointSizes[indexPath.row])";

        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tmpString:NSString = font.fontName as NSString;
        let size:CGSize = tmpString.size(attributes: [NSFontAttributeName : fontForDisplay(atIndexPath: indexPath as NSIndexPath)]);
        return size.height + 20.0;
    }

    //MARK: - Utility Methods
    private func fontForDisplay(atIndexPath indexPath:NSIndexPath) -> UIFont {
        let pointSize = pointSizes[indexPath.row];
        return font.withSize(pointSize);
    }
}
