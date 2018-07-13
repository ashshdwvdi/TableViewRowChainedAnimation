//
//  TableViewController.swift
//  chainedAnimation
//
//  Created by doodleblue-92 on 17/04/18.
//  Copyright © 2018 doodleblue-92. All rights reserved.
//

import UIKit
import PreviewTransition

class TableViewController: UITableViewController {

    @IBOutlet var myTableView: UITableView!
    var coverImage = UIImage()
    struct TableViewCells {
        static var image = "imageCell"
        static var header = "headercell"
        static var text = "textCell"
        static var comment = "commentCell"
        static var actionCell = "actionCell"
        static var tagsCell = "tagsCell"
    }
    
    var isAnimating = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.isAnimating = true
            self.animateMoveRow()
        }

    }
    
    func animateMoveRow(){
        UIView.animate(withDuration: 1.0, delay: 0.8, options: UIViewAnimationOptions.curveEaseIn, animations: {
            let fromIndexPath = IndexPath(row: 1,section:0)
            let to = IndexPath(row: 0,section:0)
            self.myTableView.moveRow(at: fromIndexPath, to: to)
        }, completion: { (status) in
            
            if status{
                UIView.animate(withDuration: 0.8, delay: 0.8, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    let fromIndexPath = IndexPath(row: 2,section:0)
                    let to = IndexPath(row: 1,section:0)
                    self.myTableView.moveRow(at: fromIndexPath, to: to)
                }, completion: { (staus) in
                    if status{
                        self.handleCellVisiblilty()
                    }
                })
            }
        })
    }
   
    func handleCellVisiblilty(){
        
        let textCell = self.myTableView.cellForRow(at: IndexPath(row:3, section: 0)) as! InspiremeCell
        let actionCell = self.myTableView.cellForRow(at: IndexPath(row:4, section: 0))  as! InspiremeCell
        let commentCell = self.myTableView.cellForRow(at: IndexPath(row:5, section: 0))  as! InspiremeCell
        
        UIView.animate(withDuration: 0.8, animations: {
            textCell.alpha = 0.0
            actionCell.alpha = 0.0
            commentCell.alpha = 0.0
        }) { (status) in
            UIView.animate(withDuration: 0.4, animations: {
                actionCell.alpha = 0.0
                commentCell.alpha = 0.0
                textCell.alpha = 1.0
            }, completion: { (status) in
                UIView.animate(withDuration: 0.4, animations: {
                    commentCell.alpha = 0.0
                    actionCell.alpha = 1.0
                }, completion: { (status) in
                    UIView.animate(withDuration: 0.4, animations: {
                        commentCell.alpha = 1.0
                    })
                })
            })
        }
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
   
        let imageCell = myTableView.dequeueReusableCell(withIdentifier: TableViewCells.image) as! InspiremeCell
        let headerCell = myTableView.dequeueReusableCell(withIdentifier: TableViewCells.header) as! InspiremeCell
        let textCell = myTableView.dequeueReusableCell(withIdentifier: TableViewCells.text) as! InspiremeCell
        let actionCell = myTableView.dequeueReusableCell(withIdentifier: TableViewCells.actionCell) as! InspiremeCell
        let commentCell = myTableView.dequeueReusableCell(withIdentifier: TableViewCells.comment) as! InspiremeCell
        let tagsCell = myTableView.dequeueReusableCell(withIdentifier: TableViewCells.tagsCell) as! InspiremeCell
        imageCell.converImageView.image = coverImage
        if isAnimating{
            /// rows will be moved and dequeued differently
            if indexPath.row == 0{
                return headerCell
            }else if indexPath.row == 1{
                return tagsCell
            }else if indexPath.row == 2{
                return imageCell
            }
        }else{
            /// rows will be in their natural order
            if indexPath.row == 0{
                return imageCell
            }else if indexPath.row == 1{
                return headerCell
            }else if indexPath.row == 2{
                return tagsCell
            }
        }
        
        if indexPath.row == 3{
            return textCell
        }else if indexPath.row == 4{
            return actionCell
        }else if indexPath.row == 5{
            return commentCell
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !isAnimating{
            let hideRows = [3,4,5]
            if hideRows.contains(indexPath.row) && !isAnimating{
                cell.alpha = 0.0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isAnimating{
            /// rows will be moved and dequeued differently
            if indexPath.row == 0{
                return 80
            }else if indexPath.row == 1{
                return 50
            }else if indexPath.row == 2{
                return 250
            }
        }else{
            /// rows will be in their natural order
            if indexPath.row == 0{
                return 250
            }else if indexPath.row == 1{
                return 80
            }else if indexPath.row == 2{
                return 50
            }
        }
        
        if indexPath.row == 3{
            return 80
        }else if indexPath.row == 4{
            return 80
        }else if indexPath.row == 5{
            return 80
        }
        return 0
    }
    
}

class InspiremeCell: UITableViewCell{
    @IBOutlet weak var converImageView: UIImageView!
    @IBOutlet weak var sectionView: UIView!
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var commentCell: UITextField!
    @IBOutlet weak var postCommentButton: UIButton!
    
    @IBOutlet weak var roundTextField: UITextField!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
}
