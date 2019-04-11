//
//  TYMapNavSheet.m
//  TYGDmap
//
//  Created by TianYang on 15/12/10.
//  Copyright © 2015年 Tianyang. All rights reserved.
//

#import "TYMapNavSheet.h"

#import "HCLocationTransform.h"

//static const double pi = 3.1415926535897932384626;
//static const double xPi = 3.14159265358979324 * 3000.0 / 180.0;

# define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] > 8.0
@interface TYMapNavSheet ()
{
    NSMutableArray       * TYMapSheetTitleArray;
    NSMutableDictionary  * TYMapNavMutDic;
    NSMutableDictionary  * TYMapNavDateMutDic;
    
    CLLocationCoordinate2D _startCoor;
    CLLocationCoordinate2D _endCoor;
    NSMutableDictionary  * _Dic;

}
@end


@implementation TYMapNavSheet

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) AddMapNamewithLocationDic:(NSMutableDictionary*)LocationDataDic withstartCoor:(CLLocationCoordinate2D)startCoor withendCoor:(CLLocationCoordinate2D)endCoor
{
    TYMapSheetTitleArray = [[NSMutableArray alloc]init];
    TYMapNavDateMutDic = [[NSMutableDictionary alloc]init];
    
    _startCoor = startCoor;
    _endCoor   = endCoor;
    _Dic = [[NSMutableDictionary alloc]initWithDictionary:LocationDataDic];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        
        NSString *TYurlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=%@,%@&destination=%@,%@&mode=driving&rc=cab",[NSString stringWithFormat:@"%f",_startCoor.latitude],[NSString stringWithFormat:@"%f",_startCoor.longitude],[NSString stringWithFormat:@"%f",_endCoor.latitude],[NSString stringWithFormat:@"%f",_endCoor.longitude]];
        
        MYLog(@"百度地图经纬度: %f  %f",_endCoor.latitude, _endCoor.longitude);

        NSDictionary *dic = @{@"name": @"百度地图",
                              @"url": TYurlString};
        [TYMapSheetTitleArray addObject:dic];
        
    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
        
        HCLocationTransform *beforeLocation = [[HCLocationTransform alloc] initWithLatitude:endCoor.latitude andLongitude:endCoor.longitude];
        //百度转化为GD
        HCLocationTransform *afterLocation = [beforeLocation transformFromBDToGD];
        
        NSString *TYurlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=cab&sid=BGVIS1&slat=%@&slon=%@&did=BGVIS2&sname=我的位置&dlat=%@&dlon=%@&dev=0&m=0&t=0",[NSString stringWithFormat:@"%f",_startCoor.latitude],[NSString stringWithFormat:@"%f",_startCoor.longitude],[NSString stringWithFormat:@"%f",afterLocation.latitude],[NSString stringWithFormat:@"%f",afterLocation.longitude]];
        
        MYLog(@"转换后的高德地图经纬度: %f  %f",afterLocation.latitude, afterLocation.longitude);

        NSDictionary *dic = @{@"name": @"高德地图",
                              @"url": TYurlString};
        [TYMapSheetTitleArray addObject:dic];
        
    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]){
        
        //http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude
        
        HCLocationTransform *startBeforeLocation = [[HCLocationTransform alloc] initWithLatitude:startCoor.latitude andLongitude:startCoor.longitude];
        //百度转化为GD
        HCLocationTransform *startAfterLocation = [startBeforeLocation transformFromBDToGD];
        
        HCLocationTransform *beforeLocation = [[HCLocationTransform alloc] initWithLatitude:endCoor.latitude andLongitude:endCoor.longitude];
        //百度转化为GD
        HCLocationTransform *afterLocation = [beforeLocation transformFromBDToGD];
        //comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving
        NSString *TYurlString = [NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航测试",@"nav123456",afterLocation.latitude, afterLocation.longitude];
        
//        NSString *TYurlString = [NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%f,%f¢er=%f,%f&directionsmode=transit", _endCoor.latitude, _endCoor.longitude, _startCoor.latitude, _startCoor.longitude];
        
        NSDictionary *dic = @{@"name": @"谷歌地图",
                              @"url": TYurlString};
        [TYMapSheetTitleArray addObject:dic];
        
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        
        HCLocationTransform *beforeLocation = [[HCLocationTransform alloc] initWithLatitude:endCoor.latitude andLongitude:endCoor.longitude];
        //百度转化为GD
        HCLocationTransform *afterLocation = [beforeLocation transformFromBDToGD];
        
        NSString *TYurlString = [NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=2&policy=0",afterLocation.latitude, afterLocation.longitude];
        NSDictionary *dic = @{@"name": @"腾讯地图",
                              @"url": TYurlString};
        [TYMapSheetTitleArray addObject:dic];
    }
    
}

-(void) AddSheetViewsuperView:(UIViewController *)superViewColtroller withLocationDic:(NSMutableDictionary*)TYMapLocationDic withstartCoor:(CLLocationCoordinate2D)startCoor withendCoor:(CLLocationCoordinate2D)endCoor
{
    
    [self AddMapNamewithLocationDic:TYMapLocationDic withstartCoor:startCoor withendCoor:endCoor];
    
//    HCLocationTransform *beforeLocation = [[HCLocationTransform alloc] initWithLatitude:startCoor.latitude andLongitude:startCoor.longitude];
//        //百度转化为GD
//    HCLocationTransform *afterLocation = [beforeLocation transformFromBDToGD];
//
//    double endlat =0.0;
//    double endlng =0.0;
//    transform_baidu_from_mars(endCoor.latitude, endCoor.longitude, &endlat, &endlng);
//
//    CLLocationCoordinate2D startStr = CLLocationCoordinate2DMake(afterLocation.latitude, afterLocation.longitude);
//
//    CLLocationCoordinate2D endStr = CLLocationCoordinate2DMake(endlat, endlng);
    
    if (IOS8) {
        UIAlertController * TYMapNavSheetController = [UIAlertController alertControllerWithTitle:nil  message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [TYMapNavSheetController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //按钮触发的方法
        }]];
        [TYMapNavSheetController addAction:[UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //按钮触发的方法
            MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate: startCoor addressDictionary:nil]];
            //目的地的位置
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil ]];
            
            
//            //按钮触发的方法
//            MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate: startStr addressDictionary:nil]];
//            //目的地的位置
//            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endStr addressDictionary:nil ]];
            toLocation.name = [NSString stringWithFormat:@"%@",TYMapLocationDic[@"endName"]];//endName
            currentLocation.name = [NSString stringWithFormat:@"%@",TYMapLocationDic[@"startName"]];
            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
            NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
            //打开苹果自身地图应用，并呈现特定的item
            [MKMapItem openMapsWithItems:items launchOptions:options];
        }]];
        for (NSDictionary * Dic in TYMapSheetTitleArray) {
            [TYMapNavSheetController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@", [Dic objectForKey:@"name"]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //按钮触发的方法
                NSDictionary *mapDic = Dic;
                NSString *urlString = mapDic[@"url"];
                urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [NSURL URLWithString:urlString];
                [[UIApplication sharedApplication] openURL:url];
            }]];
        }
        [superViewColtroller presentViewController:TYMapNavSheetController animated:YES completion:nil];
    }else{
        UIActionSheet * TYMapNavSheet = [[UIActionSheet alloc] init];
        [TYMapNavSheet addButtonWithTitle:@"苹果地图"];
        for (NSDictionary * Dic in TYMapSheetTitleArray) {
            [TYMapNavSheet addButtonWithTitle:[NSString stringWithFormat:@"%@", [Dic objectForKey:@"name"]]];
        }
        [TYMapNavSheet addButtonWithTitle:@"取消"];
        TYMapNavSheet.delegate = self;
        [TYMapNavSheet showInView:superViewColtroller.view];
    }
}

-(void) actionsheetClick:(NSInteger)BtnIndex
{
    if (BtnIndex == 0) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        //目的地的位置
        //由于与百度地图所转化的经纬度坐标存在差异通过 transform_baidu_from_mars方法进行转化（使用转化之后的坐标）
        double lat =0.0;
        double lng =0.0;
        transform_baidu_from_mars(_endCoor.latitude, _endCoor.longitude, &lat, &lng);
        
//        MYLog(@"++++++ %f%f",lat, lng);
        
        CLLocation *location2 = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        
        CLLocationCoordinate2D coor2 =location2.coordinate;
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coor2 addressDictionary:nil]];
        
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation,nil];
        
        NSDictionary *options =@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard],MKLaunchOptionsShowsTrafficKey:@YES};
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];

    } else{
        if (BtnIndex < [TYMapSheetTitleArray count]+1) {
            NSDictionary *mapDic = TYMapSheetTitleArray[BtnIndex-1];
            NSString *urlString = mapDic[@"url"];
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

const double x_pi = M_PI * 3000.0 / 180.0;
void transform_baidu_from_mars(double bd_lat,double bd_lon, double *gg_lat,double *gg_lon)
{
    double x = bd_lon -0.0065, y = bd_lat - 0.006;
    double z =sqrt(x * x + y * y) - 0.00002 * sin(y *x_pi);
    double theta =atan2(y, x) - 0.000003 *cos(x * x_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}

- (void) ShowMapNavSheetSuperView:(UIViewController *)ViewColtroller withLocationDic:(NSMutableDictionary*)LocationNameDic withstartCoor:(CLLocationCoordinate2D)startCoor withendCoor:(CLLocationCoordinate2D)endCoor{

    
    [self AddSheetViewsuperView:ViewColtroller withLocationDic:LocationNameDic withstartCoor:startCoor withendCoor:endCoor ];
}

-(void) actionSheetBtnClick:(NSInteger)BtnIndex
{
    [self actionsheetClick:BtnIndex];
}


@end
