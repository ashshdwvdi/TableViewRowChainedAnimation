//
//  HomeViewTableViewController.swift
//  chainedAnimation
//
//  Created by doodleblue-92 on 17/04/18.
//  Copyright © 2018 doodleblue-92. All rights reserved.
//

import UIKit
import PreviewTransition

class HomeViewTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let imagesArray = [#imageLiteral(resourceName: "salamander"),#imageLiteral(resourceName: "image1"),#imageLiteral(resourceName: "image2"),#imageLiteral(resourceName: "image3"),#imageLiteral(resourceName: "image4")]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var zoomContainerView: UIView!
    @IBOutlet weak var zoomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        self.zoomContainerView.isHidden = true
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imagesArray.count
    }

    func animateZoomImage(){
        if let indexPath = (tableView.indexPathForSelectedRow),
            let cell = tableView.cellForRow(at: indexPath){
            self.zoomImageView.frame = cell.frame
            UIView.animate(withDuration: 0.7) {
                self.zoomImageView.frame.origin.x = 0.0
                self.zoomImageView.frame.origin.y = (self.navigationController?.navigationBar.frame.height)!
            }
        }
    }
    
    func pushtToDetailsView(image: UIImage){
        self.zoomImageView.image = image
        self.zoomContainerView.isHidden = false
        animateZoomImage()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7, execute: {
            self.zoomContainerView.isHidden = true
            let storyboard = UIStoryboard(name:"Main", bundle:nil)
            let detailsVc = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
            detailsVc.coverImage = image
            self.navigationController?.pushViewController(detailsVc, animated: true)
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parallaxCell", for: indexPath) as! ParallaxCell
        cell.setImage(imagesArray[indexPath.row], title: indexPath.row.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushtToDetailsView(image: imagesArray[indexPath.row])
    }
}
