
//
//  XWUser.h
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWUser : NSObject

/// 字符串型的用户UID
@property(nonatomic,copy) NSString *idstr;


/// 友好显示名称
@property(nonatomic,copy) NSString *name;


/// 用户头像地址（中图），50×50像素
@property(nonatomic,copy) NSString *profile_image_url;

/// verified_type 没有认证:-1   认证用户:0  企业认证:2,3,5  达人:220
@property(nonatomic,assign) int verified_type;

//var verifiedTypeImage: UIImage? {
//    switch verified_type {
//    case 0:
//        return UIImage(named: "avatar_vip")
//    case 2,3,5:
//        return UIImage(named: "avatar_enterprise_vip")
//    case 220:
//        return UIImage(named: "avatar_grassroot")
//    default:
//        return nil
//    }
//}


/// 会员等级 1-6
@property(nonatomic,assign) int mbrank;


// 计算型属性,根据不同会员等级返回不同的图片
//var mbrankImage: UIImage? {
//    if mbrank > 0 && mbrank <= 6 {
//        return UIImage(named: "common_icon_membership_level\(mbrank)")
//    }
//    
//    return nil
//}

@end
