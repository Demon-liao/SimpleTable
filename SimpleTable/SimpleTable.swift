//
//  SimpleTable.swift
//  SimpleTable
//
//  Created by demon on 14-7-3.
//  Copyright (c) 2014年 demon. All rights reserved.
//

import UIKit

class SimpleTable: UIViewController,UITableViewDelegate, UITableViewDataSource{
//
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        // Custom initialization
//    }
    var dwarves:Array<String>=[]
    var computers=NSMutableArray()
    let CellTable="CellTable"
    @IBOutlet var SimpletableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dwarves=["sleepy","sneezy","bashful","happy","doc"]
        self.computers=[
            ["Name":"MACBOOK","Color":"White"],
            ["Name":"MACBOOK Pro","Color":"Silver"],
            ["Name":"IMac","Color":"Silver"],
            ["Name":"Mac Pro","Color":"Silver"]
        ]
        SimpletableView.tableHeaderView=UISearchBar(frame: CGRectMake(0,0,320,44))
        //var tableView:UITableView=SimpletableView.viewWithTag(1) as UITableView
        SimpletableView.registerClass(TableCell.self, forCellReuseIdentifier: CellTable)
                // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool){
       

        //elf.tabBarController.navigationController.setNavigationBarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 2 //需要返回确定几个section
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        
        //return self.computers.count

        if(section==0){
            return self.dwarves.count

        }else{
            return self.computers.count
        }
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!)->UITableViewCell!{
        let SimleTabledentifier="SimleTabledentifier"
        //此为cell的Identifier标志，TableView里面必须有cell才行
        //tableview里面可以加入多个cell
        if(indexPath.section==0){
            var cell:UITableViewCell?=tableView.dequeueReusableCellWithIdentifier(SimleTabledentifier) as? UITableViewCell
            
            if(cell==nil){
                cell=UITableViewCell(
                    style:UITableViewCellStyle.Default,
                    reuseIdentifier:SimleTabledentifier
                )
                // init(style: UITableViewCellStyle, reuseIdentifier: String!)
            }
            var image:UIImage=UIImage(named:"star.png")
            var Himage:UIImage=UIImage(named:"star2.png")
            cell!.imageView.image=image
            cell!.imageView.highlightedImage=Himage
            cell!.textLabel.text = self.dwarves[indexPath.row] as String
            cell!.textLabel.font=UIFont.boldSystemFontOfSize(20)//需要设置高度，如果高度小于文字大小，文字会默认最大字体
            cell!.detailTextLabel.text="1哈"

            return cell
        }else{
            var cell2:TableCell=tableView.dequeueReusableCellWithIdentifier(CellTable) as TableCell
            var rowData:NSDictionary=self.computers[indexPath.row] as NSDictionary
            //println(rowData)
            cell2.name=rowData["Name"] as? NSString
            cell2.color=rowData["Color"] as? NSString
            return cell2
        }
        
        
    }
    func tableView(tableView: UITableView!, indentationLevelForRowAtIndexPath indexPath: NSIndexPath!) -> Int{
        return indexPath.row
    }
    
    func tableView(tableView: UITableView!, willSelectRowAtIndexPath indexPath: NSIndexPath!) -> NSIndexPath!{
        if(indexPath.section==0){
            if(indexPath.row==0){
                return nil
            }else{
                return indexPath
            }
        }else{
            return indexPath
        }
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var alert=UIAlertView()
        if(indexPath.section==0){
            var rowValue:NSString=self.dwarves[indexPath.row]
            var msg="你选择了\(rowValue)"
            alert.message=msg
            alert.addButtonWithTitle("YES")
            alert.show()
            tableView.deselectRowAtIndexPath(indexPath,animated:true)//淡出选择
        }else{
            //插入行操作
            var row=indexPath.row
            var _row = self.computers.count
            if(row==(_row-2)){
                var _indexPath = NSIndexPath(forRow:_row-1,inSection:1)
                self.computers.addObject(["Name":"MACBOOK","Color":"White"])
                tableView.insertRowsAtIndexPaths([_indexPath],withRowAnimation:UITableViewRowAnimation.Fade)
                //删除操作
/*              self.computers.removeObjectAtIndex(row)
                tableView.deleteRowsAtIndexPaths([indexPath],withRowAnimation:UITableViewRowAnimation.Fade)
*/

            }
//            alert.message="\(row)"
//            alert.addButtonWithTitle("YES")
//            alert.show()
        }
        
    }
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
       return 70        
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
