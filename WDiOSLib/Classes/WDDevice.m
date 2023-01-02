//
//  WindDevice.m
//  WDiOSBase
//
//  Created by Wind on 2022/12/29.
//

#import "WDDevice.h"

#include <mach/mach.h> // 获取内存

#import <CoreTelephony/CTTelephonyNetworkInfo.h> // 获取设备运营商
#import <CoreTelephony/CTCarrier.h> // 获取设备运营商

#import <sys/sysctl.h> // CPU 类型获取
#import <sys/utsname.h>

#import <ifaddrs.h> // 获取ip
#import <arpa/inet.h> // 获取ip
#import <net/if.h> // 获取ip

#import <AdSupport/AdSupport.h>
#import <CoreLocation/CoreLocation.h>

#import <SystemConfiguration/SystemConfiguration.h>
#import<SystemConfiguration/CaptiveNetwork.h>

#include <net/if_dl.h>


#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"



@implementation WDDevice
// 系统名称
+ (NSString *)getDeviceSystemName {
    return [[UIDevice currentDevice]systemName];
}

// 系统版本号
+ (NSString *)getDeviceSystemVersion {
    return [[UIDevice currentDevice]systemVersion];
}

// 设备用户名称
+ (NSString *)getDeviceSettingName {
    return [[UIDevice currentDevice]name];
}

// 设备机型
+ (NSString *)getDeviceTypeString {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if([platform isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    if([platform isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    if([platform isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    if([platform isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
    if([platform isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
    if([platform isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
    if([platform isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
    if([platform isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    if([platform isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    if([platform isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    if([platform isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
    if([platform isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    if([platform isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    if([platform isEqualToString:@"iPhone9,3"])  return @"iPhone 7";
    if([platform isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone9,4"])  return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"])   return @"iPhone SE2";
    if ([platform isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"])   return @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"])   return @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"])   return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"])   return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,7"])   return @"iPhone 14";
    if ([platform isEqualToString:@"iPhone14,8"])   return @"iPhone 14 Plus";
    if ([platform isEqualToString:@"iPhone15,2"])   return @"iPhone 14 Pro";
    if ([platform isEqualToString:@"iPhone15,3"])   return @"iPhone 14 Pro Max";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod Touch 7G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,11"])     return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])     return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5 inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5 inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,5"])      return @"iPad 6th Gen (WiFi)";
    if ([platform isEqualToString:@"iPad7,6"])      return @"iPad 6th Gen (WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad8,1"])      return @"iPad Pro 3rd Gen (11 inch, WiFi)";
    if ([platform isEqualToString:@"iPad8,2"])      return @"iPad Pro 3rd Gen (11 inch, 1TB, WiFi)";
    if ([platform isEqualToString:@"iPad8,3"])      return @"iPad Pro 3rd Gen (11 inch, WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad8,4"])      return @"iPad Pro 3rd Gen (11 inch, 1TB, WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad8,5"])      return @"iPad Pro 3rd Gen (12.9 inch, WiFi)";
    if ([platform isEqualToString:@"iPad8,6"])      return @"iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi)";
    if ([platform isEqualToString:@"iPad8,7"])      return @"iPad Pro 3rd Gen (12.9 inch, WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad8,8"])      return @"iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad11,1"])     return @"iPad mini 5th Gen (WiFi)";
    if ([platform isEqualToString:@"iPad11,2"])     return @"iPad mini 5th Gen";
    if ([platform isEqualToString:@"iPad11,3"])     return @"iPad Air 3rd Gen (WiFi)";
    if ([platform isEqualToString:@"iPad11,4"])     return @"iPad Air 3rd Gen";
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";
    if ([platform isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    // 如果全部匹配不上，则返回原始类型
    return platform;
}

// 设备类型名称
+ (NSString *)getDeviceModel {
    return [[UIDevice currentDevice]model];
}

// 设备内部编号
+ (NSString *)getDeviceMachine {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
}

// 设备内存
+ (CGFloat)getDeviceTotalMemory {
    //return ceil([NSProcessInfo processInfo].physicalMemory);
    return ceil([NSProcessInfo processInfo].physicalMemory/(1024.0*1024.0)*10)/10;
}

// 磁盘内存
+ (CGFloat)getDeviceTotalDisk {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return 0;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = 0;
    return ceil(space/(1024.0*1024.0)*10)/10;
}

// 磁盘剩余内存
+ (CGFloat)getDeviceFreeDisk {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager]
                           attributesOfFileSystemForPath:NSHomeDirectory()
                           error:&error];
    if (error) return 0;
    int64_t space = [[attrs objectForKey:NSFileSystemFreeSize]longLongValue];
    if (space < 0) space = 0;
    return ceil(space/(1024.0*1024.0)*10)/10;
}

// 设备屏幕尺寸
+ (NSString *)getDeviceLogicalScreenSize {
    CGSize size_screen = [[UIScreen mainScreen]bounds].size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGFloat width = size_screen.width * scale_screen;
    CGFloat height = size_screen.height * scale_screen;
    return [NSString stringWithFormat:@"%.fx%.f", width, height];
}

// 设备CPU个数
+ (NSInteger)getDeviceCPUNum{
    unsigned int ncpu;
    size_t len = sizeof(ncpu);
    sysctlbyname("hw.ncpu", &ncpu, &len, NULL, 0);
    NSInteger cpuNum = ncpu;
    return cpuNum;
}

// IDFA
+ (NSString *)getDeviceIDFA {
    return [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
}

+ (NSString *)getDeviceIDFV {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)getMacAddress {
  int         mgmtInfoBase[6];
  char        *msgBuffer = NULL;
  size_t       length;
  unsigned char    macAddress[6];
  struct if_msghdr  *interfaceMsgStruct;
  struct sockaddr_dl *socketStruct;
  NSString      *errorFlag = NULL;
   
  // Setup the management Information Base (mib)
  mgmtInfoBase[0] = CTL_NET;    // Request network subsystem
  mgmtInfoBase[1] = AF_ROUTE;    // Routing table info
  mgmtInfoBase[2] = 0;
  mgmtInfoBase[3] = AF_LINK;    // Request link layer information
  mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
   
  // With all configured interfaces requested, get handle index
  if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
    errorFlag = @"if_nametoindex failure";
  else
  {
    // Get the size of the data available (store in len)
    if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
      errorFlag = @"sysctl mgmtInfoBase failure";
    else
    {
      // Alloc memory based on above call
      if ((msgBuffer = malloc(length)) == NULL)
        errorFlag = @"buffer allocation failure";
      else
      {
        // Get system information, store in buffer
        if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
          errorFlag = @"sysctl msgBuffer failure";
      }
    }
  }
   
  // Befor going any further...
  if (errorFlag != NULL)
  {
    NSLog(@"Error: %@", errorFlag);
    return errorFlag;
  }
   
  // Map msgbuffer to interface message structure
  interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
   
  // Map to link-level socket structure
  socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
   
  // Copy link layer address data in socket structure to an array
  memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
   
  // Read from char array into a string object, into traditional Mac address format
  NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                 macAddress[0], macAddress[1], macAddress[2],
                 macAddress[3], macAddress[4], macAddress[5]];
  NSLog(@"Mac Address: %@", macAddressString);
   
  // Release the buffer memory
  free(msgBuffer);
   
  return macAddressString;
}

//设备电量
+ (CGFloat)getDeviceBatteryLevel{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return ceil([UIDevice currentDevice].batteryLevel*100)/100;
}

+ (BOOL)getDeviceBatteryChargingState {
    if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateCharging) {
        return YES;
    }
    return NO;
}

//是否开启WiFi
+ (BOOL)deviceisWiFiEnabled {
    NSCountedSet * cset = [NSCountedSet new];
    struct ifaddrs *interfaces;
    if( ! getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}

//是否代理
+ (BOOL)deviceIsUseProxy{
    CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
    NSDictionary *dictProxy = (__bridge  id)proxySettings;
    BOOL isUseProxy = [[dictProxy objectForKey:@"HTTPEnable"] boolValue];
    CFRelease(proxySettings);
    return isUseProxy;
}

//是否模拟器
+ (BOOL)deviceIsSimulator {
    return TARGET_IPHONE_SIMULATOR;
}

//是否越狱
+ (BOOL)isJailbroken{
    //越狱检测
    BOOL root = NO;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *pathArray = @[@"/etc/ssh/sshd_config",
                           @"/usr/libexec/ssh-keysign",
                           @"/usr/sbin/sshd",
                           @"/bin/sh",
                           @"/bin/bash",
                           @"/etc/apt",
                           @"/Application/Cydia.app/",
                           @"/Library/MobileSubstrate/MobileSubstrate.dylib"
    ];
    for (NSString *path in pathArray) {
        root = [fileManager fileExistsAtPath:path];
        // 如果存在这些目录，就是已经越狱
        if (root) {
            break;
        }
    }
    
    if(root){
        return YES;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
        return YES;
    }
    return NO;
}

//iPhone中SIM卡的个数
- (int)getSimCountInPhone {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    if(@available(iOS 12.0, *)) {
        NSDictionary *ctDict = networkInfo.serviceSubscriberCellularProviders;
        if([ctDict allKeys].count>1){
            NSArray*keys = [ctDict allKeys];
            CTCarrier*carrier1 = [ctDict objectForKey:keys[0]];
            CTCarrier*carrier2 = [ctDict objectForKey:keys[1]];
            if(carrier1.mobileCountryCode.length && carrier2.mobileCountryCode.length){
                return 2;
            } else if(!carrier1.mobileCountryCode.length && !carrier2.mobileCountryCode.length){
                return 0;
            } else {
                return 1;
            }
        } else if([ctDict allKeys].count==1){
            NSArray*keys = [ctDict allKeys];
            CTCarrier*carrier1 = [ctDict objectForKey:keys[0]];
            if(carrier1.mobileCountryCode.length){
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    } else {
        CTCarrier*carrier = [networkInfo subscriberCellularProvider];
        NSString*name = carrier.mobileCountryCode;
        if (name.length) {
            return 1;
        } else {
            return 0;
        }
    }
}

//SIM卡信息
+ (NSDictionary *)getSimInfoInPhone {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSMutableDictionary *simInfo = [NSMutableDictionary dictionary];
    if(@available(iOS 12.0, *)) {
        NSDictionary *ctDict = networkInfo.serviceSubscriberCellularProviders;
        if([ctDict allKeys].count>1){
            NSArray*keys = [ctDict allKeys];
            CTCarrier*carrier1 = [ctDict objectForKey:keys[0]];
            CTCarrier*carrier2 = [ctDict objectForKey:keys[1]];
            if(carrier1.mobileCountryCode.length && carrier2.mobileCountryCode.length){
                //[simInfo setValue:carrier1.yy_modelToJSONObject forKey:@"sim1"];
                //[simInfo setValue:carrier2.yy_modelToJSONObject forKey:@"sim2"];
            } else if(carrier1.mobileCountryCode.length && !carrier2.mobileCountryCode.length) {
                //[simInfo setValue:carrier1.yy_modelToJSONObject forKey:@"sim1"];
            } else if(!carrier1.mobileCountryCode.length && carrier2.mobileCountryCode.length) {
                //[simInfo setValue:carrier2.yy_modelToJSONObject forKey:@"sim2"];
            } else {
                //[simInfo setDictionary:@{}];
            }
        } else if([ctDict allKeys].count==1){
            NSArray*keys = [ctDict allKeys];
            CTCarrier*carrier1 = [ctDict objectForKey:keys[0]];
            if(carrier1.mobileCountryCode.length){
                //[simInfo setValue:carrier1.yy_modelToJSONObject forKey:@"sim1"];
            } else {
                [simInfo setDictionary:@{}];
            }
        } else {
            [simInfo setDictionary:@{}];
        }
    } else {
        CTCarrier*carrier = [networkInfo subscriberCellularProvider];
        NSString*name = carrier.mobileCountryCode;
        if (name.length) {
            //[simInfo setValue:carrier.yy_modelToJSONObject forKey:@"sim1"];
        } else {
            [simInfo setDictionary:@{}];
        }
    }
    return [simInfo copy];
}

+ (NSString *)getScreenResolution {
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGFloat width = size_screen.width*scale_screen;
    CGFloat height = size_screen.height*scale_screen;
    return [NSString stringWithFormat:@"%d*%d",(int)width,(int)height];

}

+ (NSString *)getScreenResolutionHeight {
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    //CGFloat width = size_screen.width*scale_screen;
    CGFloat height = size_screen.height*scale_screen;
    return [NSString stringWithFormat:@"%d",(int)height];
}

+ (NSString *)getScreenResolutionWidth {
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGFloat width = size_screen.width*scale_screen;
    //CGFloat height = size_screen.height*scale_screen;
    return [NSString stringWithFormat:@"%d",(int)width];
}

+ (NSString *)fetchWiFiInfo {
    
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    if ([SSIDInfo objectForKey:@"SSID"]) {
        return [SSIDInfo objectForKey:@"SSID"];
    }
    return @"";
}

+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)getIPAddress {
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0) {
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ) {
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0)continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString stringWithFormat:@"%s",
                            inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    for (int i = 0; i < ips.count; i++) {
        if(ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@", ips.lastObject];
        }
    }
    return deviceIP;
}

+ (NSString *)getBattery {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    if ((int)deviceLevel == -1) { // simulator
        return @"";
    }
    return [NSString stringWithFormat:@"%d",(int)(deviceLevel * 100)];
}

+ (BOOL)isWIFIConnection {
    BOOL ret = YES;
    struct ifaddrs * first_ifaddr, * current_ifaddr;
    NSMutableArray* activeInterfaceNames = [[NSMutableArray alloc] init];
    getifaddrs( &first_ifaddr );
    current_ifaddr = first_ifaddr;
    while( current_ifaddr!=NULL ) {
        if( current_ifaddr->ifa_addr->sa_family==0x02 ) {
            [activeInterfaceNames addObject:[NSString stringWithFormat:@"%s",
                                             current_ifaddr->ifa_name]];
        }
        current_ifaddr = current_ifaddr->ifa_next;
    }
    ret = [activeInterfaceNames containsObject:@"en0"] || [activeInterfaceNames containsObject:@"en1"];
    return ret;
}

// iOS11 之前使用该方法获取
+ (NSString *)getTotalDiskSpace{
    
    if (@available(iOS 11.0, *)) {
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()];
        NSDictionary *results = [fileURL resourceValuesForKeys:@[NSURLVolumeTotalCapacityKey]
                                                         error:nil];
        NSLog(@"剩余可用空间:%@",results[NSURLVolumeTotalCapacityKey]);
        return  [results[NSURLVolumeTotalCapacityKey] stringValue];
    } else {
        long totalsize = -1;
        NSError *error = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSDictionary *dictionary = [[NSFileManager defaultManager]
                                    attributesOfFileSystemForPath:[paths lastObject]
                                    error: &error];
        if (dictionary)
        {
           NSNumber *_total = [dictionary objectForKey:NSFileSystemSize];
           totalsize = [_total unsignedLongLongValue];
        } else
        {
           NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld",
                 [error domain], (long)[error code]);
        }
        return [NSString stringWithFormat:@"%ld",totalsize];
        
    }
}

+ (NSString *)getFreeDiskSpace {
    if (@available(iOS 11.0, *)) {
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()];
            NSDictionary *results = [fileURL
                                     resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey]
                                     error:nil];
        NSLog(@"总空间:%@",results[NSURLVolumeAvailableCapacityForImportantUsageKey]);
        return [results[NSURLVolumeAvailableCapacityForImportantUsageKey] stringValue];
    } else {
        long freesize = -1;
        NSError *error = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSDictionary *dictionary = [[NSFileManager defaultManager]
                                    attributesOfFileSystemForPath:[paths lastObject]
                                    error: &error];
        if (dictionary)
        {
           NSNumber *_free = [dictionary objectForKey:NSFileSystemFreeSize];
           freesize = [_free unsignedLongLongValue];
        } else
        {
           NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
        }
        return [NSString stringWithFormat:@"%ld",freesize];
    }
}

// 获取当前可用内存
+ (NSString *)getAvailableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        //return NSNotFound;
        return @"";
    }
    long long size = ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
    return [[NSNumber numberWithLongLong:size] stringValue];
}
 
+ (NSString *)getPhysicalSize {
    float scale = [[UIScreen mainScreen] scale];
    float ppi = scale * ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 132 : 163);
    float width = ([[UIScreen mainScreen] bounds].size.width * scale);
    float height = ([[UIScreen mainScreen] bounds].size.height * scale);
    float horizontal = width / ppi, vertical = height / ppi;
    float diagonal = sqrt(pow(horizontal, 2) + pow(vertical, 2));
    return [[NSNumber numberWithFloat:diagonal] stringValue];
}

+ (NSString *)getSerialNumber {
    return @"";
    //return [[UIDevice currentDevice] uniqueIdentifier];
}

+ (NSString *)getCarrierSignalStrength {
    if(@available(iOS 13.0, *)) {
        NSArray *arr = [UIApplication sharedApplication].connectedScenes.allObjects;
        UIWindowScene *scene = arr.firstObject;
        UIStatusBarManager *statusBarManager = scene.statusBarManager;
        id statusBar =nil;
        if([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
            UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
            if([localStatusBar respondsToSelector:@selector(statusBar)]) {
                statusBar = [localStatusBar performSelector:@selector(statusBar)];
            }
        }
        if(statusBar) {
            id currentData = [[statusBar valueForKeyPath:@"_statusBar"] valueForKeyPath:@"currentData"];
            id cellularEntry = [currentData valueForKeyPath:@"cellularEntry"];
            if([cellularEntry isKindOfClass:NSClassFromString(@"_UIStatusBarDataIntegerEntry")]) {
                int signalStrength = [[cellularEntry valueForKey:@"displayValue"]intValue];
                NSLog(@"signalStrength: %d",signalStrength);
                return [[NSNumber numberWithInt:signalStrength] stringValue];
            }
        }
        return @"";
    } else {
        UIApplication *app = [UIApplication sharedApplication];

        NSArray*subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
        NSString*dataNetworkItemView =nil;
        for(id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
               dataNetworkItemView = subview;
               break;
            }
        }
        NSInteger signalStrength = [[dataNetworkItemView valueForKey:@"signalStrengthRaw"]intValue];
        NSString *signalStrengthStr = [NSString stringWithFormat:@"%lddBm",(long)signalStrength];
        return signalStrengthStr;
    }
}

+ (NSString *)getCurrentTimeStamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.0f", a];//转为字符型
    NSLog(@"timeString:%@",timeString);
    return timeString;
}

+ (BOOL)isOpenTheProxy {
    
#ifdef DEBUG
    return NO;
#else
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]) {
        return NO;
    } else {
        return YES;
    }
#endif
}

+ (BOOL)isVPNOn {
   BOOL flag = NO;
   NSString *version = [UIDevice currentDevice].systemVersion;
   // need two ways to judge this.
   if (version.doubleValue >= 9.0) {
       NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
       NSArray *keys = [dict[@"__SCOPED__"] allKeys];
       for (NSString *key in keys) {
           if ([key rangeOfString:@"tap"].location != NSNotFound ||
               [key rangeOfString:@"tun"].location != NSNotFound ||
               [key rangeOfString:@"ipsec"].location != NSNotFound ||
               [key rangeOfString:@"ppp"].location != NSNotFound){
               flag = YES;
               break;
           }
       }
   } else{
       struct ifaddrs *interfaces = NULL;
       struct ifaddrs *temp_addr = NULL;
       int success = 0;
       
       // retrieve the current interfaces - returns 0 on success
       success = getifaddrs(&interfaces);
       if (success == 0) {
           // Loop through linked list of interfaces
           temp_addr = interfaces;
           while (temp_addr != NULL) {
               NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
               if ([string rangeOfString:@"tap"].location != NSNotFound ||
                   [string rangeOfString:@"tun"].location != NSNotFound ||
                   [string rangeOfString:@"ipsec"].location != NSNotFound ||
                   [string rangeOfString:@"ppp"].location != NSNotFound){
                   flag = YES;
                   break;
               }
               temp_addr = temp_addr->ifa_next;
           }
       }
       // Free memory
       freeifaddrs(interfaces);
   }
   return flag;
}

+ (NSString*)getPreferredLanguage{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:2];
    NSLog(@"当前语言:%@", preferredLang);
    return preferredLang;
}

+ (NSString*)getLocaleDisplayLanguagee {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:1];
    NSLog(@"当前语言:%@", preferredLang);
    return preferredLang;
}

+ (NSString *)getAreaCode {
//    NSLocale *currentLocale = [NSLocale currentLocale]; NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
//    return currentLocale;
    return @"";
}

+ (long)getSystemTotalUptime {
    struct timespec ts;
    if (@available(iOS 10.0, *)) {
        clock_gettime(CLOCK_MONOTONIC, &ts);
    } else {
        
    }
    return ts.tv_sec * 1000;
}

+ (long)getSystemAliveUptime {
    NSTimeInterval timeInterval = [[NSProcessInfo processInfo] systemUptime];
    return timeInterval * 1000;
}

+ (NSString *)getCarrierName {
    //获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //当前手机所属运营商名称
    NSString *mobile;
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (!carrier.isoCountryCode) {
        NSLog(@"没有SIM卡");
        mobile = @"";
    }else{
        mobile = [carrier carrierName];
    }
    return mobile;
}

+ (NSString *)getNetworkType {
  
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    NSString *currentNet = @"";
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
        currentNet = @"GPRS";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge]) {
        currentNet = @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA]){
        currentNet = @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA]){
        currentNet = @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x]){
        currentNet = @"2G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]){
        currentNet = @"HRPD";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]){
        currentNet = @"4G";
    }else if (@available(iOS 14.0, *)) {
        if (@available(iOS 14.1, *)) {
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyNRNSA]){
                currentNet = @"5G NSA";
            }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyNR]){
                currentNet = @"5G";
            }
        } else {
            // Fallback on earlier versions
        }
    }
    return currentNet;
}

+ (NSString *)getTimezone {
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSString *strZoneAbbreviation = [localZone abbreviation];
    NSRegularExpression *regularExpression = [NSRegularExpression
                                              regularExpressionWithPattern:@"[a-zA-Z]"
                                              options:0 error:nil];
    strZoneAbbreviation = [regularExpression stringByReplacingMatchesInString:strZoneAbbreviation
                                                                      options:0
                                                                        range:NSMakeRange(0, strZoneAbbreviation.length)
                                                                 withTemplate:@""];
    return strZoneAbbreviation;
}

+ (NSString *)getWiFiMac {
    NSString *idStr = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            idStr = [dict valueForKey:@"BSSID"];
        }
    }
    return idStr;
}

+ (NSString *)getWiFiSsid {
    NSString *idStr = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            idStr = [dict valueForKey:@"SSID"];
        }
    }
    return idStr;
}
@end
