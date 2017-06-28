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
        self.pictureViews=[[NSMutableArray alloc] init];
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

-(UIImageView*)addPicture:(UIImage *)picture bindTapAction:(BOOL)bindTapAction
{
    UIImageView* pictureView=[self addPicture:picture];
    if (bindTapAction) {
        UITapGestureRecognizer* tapRecog=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureViewTapped:)];
        [pictureView addGestureRecognizer:tapRecog];
    }
    return pictureView;
}

-(UIImageView*)addPicture:(UIImage*)picture
{
    if (!picture||self.pictures.count>=self.config.capacity) {
        return nil;
    }
    [self.pictures addObject:picture];
    UIImageView* pictureView=[[UIImageView alloc] initWithImage:picture];
    pictureView.contentMode=UIViewContentModeScaleAspectFill;
    pictureView.layer.cornerRadius=self.config.cornerRadius;
    pictureView.clipsToBounds=YES;
    [self addPictureView:pictureView];
    return pictureView;
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
            for (UIView* subview in view.subviews) {
                subview.tag=view.tag;
            }
            CGPoint position=[self positionOfIndex:view.tag];
            if ([view isKindOfClass:[UIImageView class]]) {
                [UIView animateWithDuration:self.config.animationDuration animations:^{
                    view.center=position;
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
    [self.pictureViews addObject:pictureView];
    NSUInteger index=self.pictures.count-1;
    NSUInteger column=index%self.config.numberOfColumns;
    NSUInteger row=index/self.config.numberOfColumns;
    pictureView.tag=index;
    pictureView.frame=CGRectMake(self.config.paddingLeft+(self.pictureWidth+self.config.columnGap)*column, self.config.paddingTop+(self.pictureHeight+self.config.rowGap)*row, self.pictureWidth, self.pictureHeight);
    [self addSubview:pictureView];
    
    UIButton* removeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    removeButton.tag=index;
    [removeButton setBackgroundImage:self.config.removeButtonImage forState:UIControlStateNormal];
    removeButton.bounds=CGRectMake(0, 0, self.config.removeButtonSize.width,self.config.removeButtonSize.height);
    removeButton.center=CGPointMake(pictureView.bounds.origin.x+self.pictureWidth+self.config.removeButtonPosition.x, pictureView.bounds.origin.y-self.config.removeButtonPosition.y);
    removeButton.tag=index;
    [removeButton addTarget:self action:@selector(removeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [pictureView addSubview:removeButton];
    [self layoutAddButton];
    
    pictureView.userInteractionEnabled=YES;
    UITapGestureRecognizer* tapRecog=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureViewTapped:)];
    [pictureView addGestureRecognizer:tapRecog];
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

-(void)bindTapOnPictureAction
{
    for (UIImageView* pictureView in self.pictureViews) {
        UITapGestureRecognizer* tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureViewTapped:)];
        [pictureView addGestureRecognizer:tapGestureRecognizer];
    }
}
-(void)unbindTapOnPictureAction
{
    for (UIImageView* pictureView in self.pictureViews) {
        for (UIGestureRecognizer* gestureRecog in pictureView.gestureRecognizers) {
            if ([gestureRecog isKindOfClass:[UITapGestureRecognizer class]]) {
                [pictureView removeGestureRecognizer:gestureRecog];
                break;
            }
        }
    }
}

-(void)pictureViewTapped:(UITapGestureRecognizer*)tapGestureRecognizer
{
    UIImageView* sender=(UIImageView*)tapGestureRecognizer.view;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pictureSelectionView:didTapOnPictureView:atIndex:)]) {
        [self.delegate pictureSelectionView:self didTapOnPictureView:sender atIndex:sender.tag];
    }
}

@end
