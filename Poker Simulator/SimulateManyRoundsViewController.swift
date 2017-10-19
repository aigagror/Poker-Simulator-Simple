//
//  SimulateManyRoundsViewController.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/17/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import UIKit

class SimulateManyRoundsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var graphTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        graphTableView.delegate = self
        graphTableView.dataSource = self
    }
    
    @IBAction func startSimulating(_ sender: Any) {
        
        // TODO: Add code here
        
    }
    
    
    @IBAction func stopSimulating(_ sender: Any) {
        
        // TODO: Add code here
        
    }
    
    
    @IBAction func reset(_ sender: Any) {
        
        // TODO: Add code here
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "graphBarCell"
        
        guard indexPath.section == 0 else {
            fatalError("Unknown section")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? BarGraphTableViewCell else {
            fatalError("Could not get graph bar cell")
        }
        
        guard let handType = HandType(rawValue: indexPath.row) else {
            fatalError("Could not get hand type")
        }
        
        cell.handType = handType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 {
            return 0.0
        }
        let height = tableView.bounds.height
        return height / 9
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
