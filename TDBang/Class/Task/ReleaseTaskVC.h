//
//  ReleaseTaskVC.h
//  TDBang
//
//  Created by sunjason on 15/7/29.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface ReleaseTaskVC : OneBaseVC
<
    UITableViewDataSource,
    UITableViewDelegate,
    QRadioButtonDelegate
>


@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tblReleaseTask;

@property (strong, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *inputContentCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskName;

@property (strong, nonatomic) IBOutlet UITableViewCell *taskPaymentCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskSalary;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskPeopleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskTiimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskDateCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskPlaceCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *taskConnectCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *releaseCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *QQNumberCell;


@property (weak, nonatomic) IBOutlet UIButton *btnRelease;
- (IBAction)actionRelease:(id)sender;


@property (weak, nonatomic) IBOutlet UITextView *tvInputTaskContent;
@property (weak, nonatomic) IBOutlet UITextField *tfTaskName;
@property (weak, nonatomic) IBOutlet UIView *vTaskPaymentType;
@property (weak, nonatomic) IBOutlet UITextField *tfSalary;
@property (weak, nonatomic) IBOutlet UITextField *tfPeopleNum;

@property (weak, nonatomic) IBOutlet UIButton *btnStartTime;
@property (weak, nonatomic) IBOutlet UIButton *btnEndTime;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UITextField *tfLocation;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfQQNumber;

@property (weak, nonatomic) IBOutlet UIView *vPaymentType;
@property (weak, nonatomic) IBOutlet UIView *vSalary;


- (IBAction)actionStartTime:(id)sender;
- (IBAction)actionEndTime:(id)sender;
- (IBAction)actionStartDate:(id)sender;
- (IBAction)actionEndDate:(id)sender;

@end
