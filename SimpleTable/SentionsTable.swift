//
//  SentionsTable.swift
//  SimpleTable
//
//  Created by demon on 14-7-7.
//  Copyright (c) 2014年 demon. All rights reserved.
//

import UIKit

class SentionsTable: UIViewController,UISearchDisplayDelegate,UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate{
   // var _self: self?
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        // Custom initialization
//    }
    let CellTable="SentionsTable"
    var names=[:]
    var keys:Array<String>=[]
    var filterNames:NSMutableArray!
    var serchController:UISearchDisplayController!
    var searchBar:UISearchBar!
    @IBOutlet var sectionTable: UITableView
    override func viewDidLoad() {
        super.viewDidLoad()
        //var nav=UINavigationBar(frame: CGRectMake(0,0,320,44))
        searchBar=UISearchBar(frame: CGRectMake(0,0,320,44))
        sectionTable.tableHeaderView=searchBar
        sectionTable.registerClass(UITableViewCell.self , forCellReuseIdentifier: CellTable)
//        
       
        filterNames=NSMutableArray.array()
        searchBar.delegate=self

        serchController=UISearchDisplayController(searchBar:searchBar,contentsController:self)
        //init(searchBar: UISearchBar!, contentsController viewController: UIViewController!)
        serchController.delegate=self;
        serchController.searchResultsDataSource=self

        var bundle:NSBundle=NSBundle.mainBundle()//获取项目的资源包
        var plistURL:NSURL=bundle.URLForResource("sortednames", withExtension: "plist")
        self.names=NSDictionary(contentsOfURL:plistURL)
        var keys=self.names.allKeys as Array<String>
        self.keys=sort(keys,backwards)
        
        
        // Do any additional setup after loading the view.
    }
    
    func backwards(s1: String, s2: String) -> Bool {
        return s1 < s2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        if(tableView.tag==1){
            return self.keys.count //需要返回确定几个section
        }else{
            return 1
        }
    }
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int)->String{
        if(tableView.tag==1){
            return self.keys[section] as String
        }else{
            return String("一共查到:\(filterNames.count)个")
        }
        
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        if(tableView.tag==1){
            var key=self.keys[section]
            var nameSection:NSArray=self.names[key] as NSArray
            return nameSection.count
        }else{
            return filterNames.count
        }
        
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!)->UITableViewCell!{
        var cell:UITableViewCell=tableView.dequeueReusableCellWithIdentifier(CellTable) as UITableViewCell
        if(tableView.tag==1){
            var key=self.keys[indexPath.section]
            var nameSection:NSArray=self.names[key] as NSArray
            cell.textLabel.text=nameSection[indexPath.row] as String
           
        }else{
           // tableView.frame.origin.y=20
//            tableView.frame.size.height=410
            //self.window.backgroundColor=UIColor.grayColor()
            if(filterNames.count>0){
                 var _row=indexPath.row
               // println(filterNames)

                cell.textLabel.text=filterNames[_row] as String
              
                
            }
        }
        
        return cell
    }
    //返回显示索引
    func sectionIndexTitlesForTableView(tableView: UITableView!)->NSArray{
        if(tableView.tag==1){
            tableView.sectionIndexColor=UIColor.grayColor()
            return self.keys
        }else{
            return NSArray()
        }
        
    }
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int)->NSString{
        if(tableView.tag==1){
            //点击返回的位置
            return self.keys[section]
        }else{
            return NSString()
        }
    }
    
    //搜索
    func searchDisplayController(controller: UISearchDisplayController!, didLoadSearchResultsTableView tableView: UITableView!){
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: CellTable)
       
    }
    func searchDisplayController(controller: UISearchDisplayController!, didShowSearchResultsTableView tableView: UITableView!){
        // tableView.frame.origin.y=20
        // tableView.frame.size.height=tableView.frame.size.height-64

         tableView.separatorInset.top=0
    }
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool{
        //self.tabBarController.navigationController.setNavigationBarHidden(true, animated: true)
        filterNames.removeAllObjects()
       
  
        if(searchString.utf16count > 0){
            var priedicate:NSPredicate=NSPredicate(){//闭包
                name,b in
                var range:NSRange=name.rangeOfString(searchString,options:NSStringCompareOptions.CaseInsensitiveSearch)
              
                return range.location != NSNotFound
            }
            for  key in self.keys{
                var matches:NSArray=self.names[key].filteredArrayUsingPredicate(priedicate) as NSArray
                filterNames.addObjectsFromArray(matches)
            }
            
        }
        
        return true
    }
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool{
        
        
        return true
    }
    override func viewWillAppear(animated: Bool){
    
      //elf.tabBarController.navigationController.setNavigationBarHidden(true, animated: true)
     }
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
