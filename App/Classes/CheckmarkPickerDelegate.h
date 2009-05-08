
@protocol CheckmarkPickerDelegate
//TODO: why an error when using CheckmarkPickerController as the type in place of 'id'?
-(void)optionSelected:(id)option;
-(NSString *)labelForOption:(id)option;
@end
