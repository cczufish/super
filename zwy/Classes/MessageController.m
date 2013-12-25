//
//  MessageController.m
//  zwy
//
//  Created by wangshuang on 12/10/13.
//  Copyright (c) 2013 sxit. All rights reserved.
//

#import "MessageController.h"
#import "MesaageIMCell.h"
#import "CoreDataManageContext.h"
#import "SessionEntity.h"
#import "PeopelInfo.h"
@implementation MessageController{
    NSArray *arrLetter;
    NSArray *arrNumber;
    BOOL  isSearching;
}

-(id)init{
    self=[super init];
    if(self){
        arrLetter =[NSMutableArray arrayWithObjects:
                          @"a",@"b",@"c",@"d",@"e",@"f",
                          @"g",@"h",@"i",@"j",@"k",@"l",
                          @"m",@"n",@"o",@"p",@"q",@"r",
                          @"s",@"t",@"u",@"v",@"w",@"x",
                          @"y",@"z",@"#",nil];
        
        arrNumber =@[@"0",@"1",@"2",@"3",@"4",
                     @"5",@"6",@"7",@"8",@"9"];
        isSearching=NO;
    }
    return self;
}

//添加聊天
- (void)btnAddPeople
{
    [self.messageView performSegueWithIdentifier:@"MessageViewToOptionChatView" sender:self.messageView];
}

- (void)BasePrepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

#pragma mark - UITableViewDateSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_messageView.searchBar.text.length!=0&&isSearching)return _arrSeaPeople.count;
    return _arrSession.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * messageIMCell =@"messageIMCell";
    MesaageIMCell * cell =[tableView dequeueReusableCellWithIdentifier:messageIMCell];
    if (!cell) {
        cell = [[MesaageIMCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                    reuseIdentifier:messageIMCell];
   
    }
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy/MM/dd HH:mm"];
    
    SessionEntity * sessionInfo=nil;
    if (_messageView.searchBar.text.length!=0&&isSearching)sessionInfo=_arrSeaPeople[indexPath.row];
    else sessionInfo=_arrSession[indexPath.row];
    
    cell.title.text=sessionInfo.session_receivername;
    cell.content.text=sessionInfo.session_content;
    cell.time.text=[dateFormatter stringFromDate:sessionInfo.session_times];
//    cell.username.text=sessionInfo.session_receivername;
    [HTTPRequest imageWithURL:sessionInfo.session_receiveravatar imageView:cell.imageMark placeholderImage:[UIImage  imageNamed:@"default_avatar"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SessionEntity * sessionInfo=nil;
    if (_messageView.searchBar.text.length!=0&&isSearching){
     sessionInfo=_arrSeaPeople[indexPath.row];
    }
    else{
    sessionInfo=_arrSession[indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PeopelInfo *info=[PeopelInfo new];
    info.tel=sessionInfo.session_receivermsisdn;
    info.eccode=sessionInfo.session_receivereccode;
    info.headPath=sessionInfo.session_receiveravatar;
    info.groupID=sessionInfo.session_groupuuid;
    info.Name=sessionInfo.session_receivername;
    self.messageView.info=info;
    self.messageView.tabBarController.navigationItem.title=@"";
    [self.messageView performSegueWithIdentifier:@"msgtochat" sender:self.messageView];
}
#pragma mark - UISearchDisplayDelegate
- (void)filteredListContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if (searchText) {
        isSearching=YES;
        if (_arrSeaPeople.count!=0||_arrSeaPeople) {
            _arrSeaPeople=NULL;
            _arrSeaPeople=[[NSArray alloc] init];
        }else{
            _arrSeaPeople=[[NSArray alloc] init];
        }
        
        NSString * strSearchbar;
        NSString* strFirstLetter=@"";
        if (searchText.length!=0)strFirstLetter=[[searchText substringToIndex:1] lowercaseString];
        
        //设置搜索条件
        if ([arrLetter containsObject: strFirstLetter])
        {
            searchText =[searchText lowercaseString];
            strSearchbar =[NSString stringWithFormat:@"SELF.session_pinyinName CONTAINS '%@'",searchText];
        }else if([arrNumber containsObject:strFirstLetter]){
            strSearchbar =[NSString stringWithFormat:@"SELF.session_receivermsisdn CONTAINS '%@'",searchText];
        }
        else{
            strSearchbar =[NSString stringWithFormat:@"SELF.session_receivername CONTAINS '%@'",searchText];
        }
        
        NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat: strSearchbar];
        self.arrSeaPeople=[self.arrSession filteredArrayUsingPredicate: predicateTemplate];
    }else {
        isSearching=NO;
    }
    [_messageView.uitableview reloadData];

}
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    //一旦SearchBar輸入內容有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    [self filteredListContentForSearchText:searchString scope:
     [[self.messageView.searchDisplayController.searchBar scopeButtonTitles]
      objectAtIndex:[self.messageView.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    //一旦Scope Button有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    [self filteredListContentForSearchText:[self.messageView.searchDisplayController.searchBar text] scope:
     [[self.messageView.searchDisplayController.searchBar scopeButtonTitles]
      objectAtIndex:searchOption]];
    return YES;
}

//输入搜索内容
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

//点击搜索按钮
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchBar:_messageView.searchBar textDidChange:nil];
    [_messageView.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self searchBar:_messageView.searchBar textDidChange:nil];
    isSearching=NO;
    [_messageView.uitableview reloadData];
    [_messageView.searchBar resignFirstResponder];
}

@end
