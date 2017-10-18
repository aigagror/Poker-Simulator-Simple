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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.handType = Hand(index: indexPath.row)
        
        return cell
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
