//
//  ViewController.swift
//  W6D4-Stretchy-NavBar
//
//  Created by Daniel Mathews on 2016-02-16.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var heightOfNavBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var oreosButton = UIButton()
    var pizzaPocketButton = UIButton()
    var popTartsButton = UIButton()
    var popsicleButton = UIButton()
    var ramenButton = UIButton()
    
    var isMenuClosed = true
    let stackView = UIStackView()
    var snacks = [String]()
    @IBOutlet weak var snacksTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        oreosButton.setImage(UIImage(named: "oreos"), forState: .Normal)
        pizzaPocketButton.setImage(UIImage(named: "pizza_pockets"), forState: .Normal)
        popTartsButton.setImage(UIImage(named: "pop_tarts"), forState: .Normal)
        popsicleButton.setImage(UIImage(named: "popsicle"), forState: .Normal)
        ramenButton.setImage(UIImage(named: "ramen"), forState: .Normal)
        
        oreosButton.addTarget(self, action: "stackViewButtonClicked:", forControlEvents: .TouchUpInside)
        pizzaPocketButton.addTarget(self, action: "stackViewButtonClicked:", forControlEvents: .TouchUpInside)
        popTartsButton.addTarget(self, action: "stackViewButtonClicked:", forControlEvents: .TouchUpInside)
        popsicleButton.addTarget(self, action: "stackViewButtonClicked:", forControlEvents: .TouchUpInside)
        ramenButton.addTarget(self, action: "stackViewButtonClicked:", forControlEvents: .TouchUpInside)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 5
        stackView.hidden = true
        
        navBar.addSubview(stackView)
        
        stackView.addArrangedSubview(oreosButton)
        stackView.addArrangedSubview(pizzaPocketButton)
        stackView.addArrangedSubview(popTartsButton)
        stackView.addArrangedSubview(popsicleButton)
        stackView.addArrangedSubview(ramenButton)
        
        let leadingConstriant = stackView.leadingAnchor.constraintEqualToAnchor(navBar.leadingAnchor, constant: 20)
        let trailingConstriant = stackView.trailingAnchor.constraintEqualToAnchor(navBar.trailingAnchor, constant: -20)
        let heightConstriant = stackView.heightAnchor.constraintEqualToConstant(100)
        let topConstriant = stackView.bottomAnchor.constraintEqualToAnchor(navBar.bottomAnchor, constant: -8)

        NSLayoutConstraint.activateConstraints([leadingConstriant, trailingConstriant, heightConstriant, topConstriant])


    }

    func stackViewButtonClicked(sender:UIButton) {
        switch sender {
        case oreosButton:
            snacks.insert("Oreos", atIndex: 0)

        case pizzaPocketButton:
            snacks.insert("Pizza Pockets", atIndex: 0)
            
        case popTartsButton:
            snacks.insert("Pop Tarts", atIndex: 0)
            
        case popsicleButton:
            snacks.insert("Popsicle", atIndex: 0)
            
        case ramenButton:
            snacks.insert("Ramen", atIndex: 0)
            
        default:
            print("Other")
        }
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func plusIconPressed(sender: UIButton) {
        
        isMenuClosed = !isMenuClosed
        heightOfNavBarConstraint.constant = isMenuClosed ? 66 : 200
        let angle = isMenuClosed ? 0 : CGFloat(M_PI_4)
        stackView.hidden = !stackView.hidden

        snacksTitleLabel.text = isMenuClosed ? "SNACKS" : "Add a SNACK"
        
        for constraint in snacksTitleLabel.superview!.constraints {
            if constraint.identifier == "centerYSnackTitle" {
                constraint.active = false
                let snacksConstant:CGFloat = isMenuClosed ? 0 : -40
                let constaint = snacksTitleLabel.centerYAnchor.constraintEqualToAnchor(navBar.centerYAnchor, constant: snacksConstant)
                constaint.identifier = "centerYSnackTitle"
                constaint.active = true
            }
            
        }
        
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: { () in

            self.view.layoutIfNeeded()
            self.plusButton.transform = CGAffineTransformMakeRotation(angle)
            
            }, completion: nil)
        
    }
    
    //MARK: TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("snackCell", forIndexPath: indexPath)
        
        let snack = snacks[indexPath.row]
        
        cell.textLabel?.text = snack
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    

}

