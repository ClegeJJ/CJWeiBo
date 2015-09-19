//
//  CJNetTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/19.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJNetTool.h"

#import "AFNetworking.h"

#import "CJFarmData.h"
@implementation CJNetTool


+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{

    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //告诉管理对象响应的数据为JSON
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr POST:url parameters:parameters
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
               if (success) {
                   success(responseObject);
               }
               
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
             if (failure) {
                 failure(error);
             }
             
         }];

}
+ (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //告诉管理对象响应的数据为JSON
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr GET:url parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          if (success) {
              success(responseObject);
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          if (failure) {
              failure(error);
          }
          
      }];
    
}


+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters farmDatas:(NSArray *)farmDatas success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{

    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //告诉管理对象响应的数据为JSON
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];

     // 2.发送请求
        [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { // 在发送请求之前调用这个block
            // 必须在这里说明要上传哪些文件

            for (CJFarmData *data in farmDatas) {
                [formData appendPartWithFileData:data.data name:data.name fileName:data.fileName mimeType:data.mimeType];
            }

        } success:^(AFHTTPRequestOperation *operation, id responseObject) {

            if (success) {
                success(responseObject);
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            if (failure) {
                failure(error);
            }

        }];

}


@end
