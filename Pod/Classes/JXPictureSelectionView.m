//
//  JXPictureSelectionView.m
//

#import "JXPictureSelectionView.h"

@interface JXPictureSelectionView ()

@property (nonatomic,assign) CGFloat pictureWidth;
@property (nonatomic,assign) CGFloat pictureHeight;

@property (nonatomic,strong) UIView* addButton;

@end

@implementation JXPictureSelectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[self initWithFrame:frame configuration:[JXPictureSelectionViewConfiguration defaultConfiguration]];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration *)configuration
{
    if (self=[super initWithFrame:frame]) {
        self.config=configuration;
        self.pictures=[[NSMutableArray alloc] init];
        self.userInteractionEnabled=YES;
        self.pictureWidth=(self.bounds.size.width-self.config.paddingLeft-self.config.paddingRight-self.config.columnGap*(self.config.numberOfColumns-1))/self.config.numberOfColumns;
        self.pictureHeight=self.pictureWidth/self.config.aspectRatio;
        self.userInteractionEnabled=YES;
        [self initAddButton];
    }
    return self;
}

-(void)initAddButton
{
    self.addButton=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.pictureWidth, self.pictureHeight)];
    UIImageView* addButtonImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.pictureWidth, self.pictureHeight)];
    addButtonImageView.image=self.config.addButtonImage;
    addButtonImageView.center=CGPointMake(self.addButton.bounds.origin.x+self.pictureWidth/2, self.addButton.bounds.origin.y+self.pictureHeight/2);
    [self.addButton addSubview:addButtonImageView];
    UITapGestureRecognizer* tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addButtonTapped:)];
    [self.addButton addGestureRecognizer:tapRecognizer];
    [self addSubview:self.addButton];
    [self layoutAddButton];
}

-(void)addPicture:(UIImage*)picture
{
    if (!picture||self.pictures.count>=self.config.capacity) {
        return;
    }
    [self.pictures addObject:picture];
    UIImageView* pictureView=[[UIImageView alloc] initWithImage:picture];
    [self addPictureView:pictureView];
}

-(void)removeButtonPressed:(UIButton*)sender
{
    [self removePictureAtIndex:sender.tag];
}

-(void)addPictures:(NSArray *)pictures
{
    for (UIImage* picture in pictures) {
        [self addPicture:picture];
    }
}

-(void)removePictureAtIndex:(NSUInteger)index
{
    if (index>=self.pictures.count) {
        return;
    }
    [self.pictures removeObjectAtIndex:index];
    for (UIView* view in self.subviews) {
        if (view==self.addButton) {
            [UIView animateWithDuration:self.config.animationDuration animations:^{
                [self layoutAddButton];
            }];
        }else if (view.tag==index) {
            [view removeFromSuperview];
        }else if (view.tag>index){
            view.tag-=1;
            CGPoint position=[self positionOfIndex:view.tag];
            if ([view isKindOfClass:[UIImageView class]]) {
                [UIView animateWithDuration:self.config.animationDuration animations:^{
                    view.center=position;
                }];
            }else if ([view isKindOfClass:[UIButton class]]) {
                [UIView animateWithDuration:self.config.animationDuration animations:^{
                    view.center=CGPointMake(position.x+self.pictureWidth/2, position.y-self.pictureHeight/2);
                }];
            }
        }
    }
}

-(void)addRemotePictureWithURL:(NSURL *)url
{
    [self.pictures addObject:url];
    UIImageView* pictureView=[[UIImageView alloc] init];
    [self addPictureView:pictureView];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pictureSelectionView:loadRemotePictureAtURL:intoPictureView:)]) {
        [self.delegate pictureSelectionView:self loadRemotePictureAtURL:url intoPictureView:pictureView];
        return;
    }
    if (self.loadRemotePictureAction) {
        self.loadRemotePictureAction(pictureView,url);
    }
}

-(void)addPictureView:(UIImageView*)pictureView
{
    NSUInteger index=(self.subviews.count-1)/2;
    NSUInteger column=index%self.config.numberOfColumns;
    NSUInteger row=index/self.config.numberOfColumns;
    pictureView.tag=index;
    pictureView.frame=CGRectMake(self.config.paddingLeft+(self.pictureWidth+self.config.columnGap)*column, self.config.paddingTop+(self.pictureHeight+self.config.rowGap)*row, self.pictureWidth, self.pictureHeight);
    [self addSubview:pictureView];
    
    UIButton* removeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    removeButton.tag=index;
    [removeButton setBackgroundImage:self.config.removeButtonImage forState:UIControlStateNormal];
    removeButton.frame=CGRectMake(0, 0, self.config.removeButtonSize.width,self.config.removeButtonSize.height);
    removeButton.center=CGPointMake(pictureView.frame.origin.x+self.pictureWidth, pictureView.frame.origin.y);
    removeButton.tag=index;
    [removeButton addTarget:self action:@selector(removeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeButton];
    [self layoutAddButton];
}

-(CGPoint)positionOfIndex:(NSUInteger)index
{
    NSUInteger column=index%self.config.numberOfColumns;
    NSUInteger row=index/self.config.numberOfColumns;
    CGPoint position=CGPointMake(self.config.paddingLeft+(self.pictureWidth+self.config.columnGap)*column+self.pictureWidth/2, self.config.paddingTop+(self.pictureHeight+self.config.rowGap)*row+self.pictureHeight/2);
    return position;
}

-(void)layoutAddButton
{
    self.addButton.hidden=self.pictures.count>=self.config.capacity;
    NSUInteger index=self.pictures.count;
    CGPoint position=[self positionOfIndex:index];
    self.addButton.center=position;
}

-(void)addButtonTapped:(UIButton*)button
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pictureSelectionView:didClickOnAddButton:)]) {
        [self.delegate pictureSelectionView:self didClickOnAddButton:self.addButton];
        return;
    }
    if (self.addButtonAction) {
        self.addButtonAction();
    }
}

@end
