//
//  UIImage+Category.h
//  Created by Dennis Deng on 12/05/04.
//

#import <UIKit/UIKit.h>

@interface UIImage (wiCategory)

// 裁剪图片
- (UIImage *) imageCroppedToRect:(CGRect)rect;
// 裁减正方形区域
- (UIImage *) squareImage;

// 保存图像文件
- (BOOL) writeImageToFileAtPath:(NSString*)aPath;

@end

