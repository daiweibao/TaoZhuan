source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
target 'ZuiMeiXinNiang' do
    #融云(老的，4月14日升级后废弃)
    # pod 'RongCloudIMLib', '2.7.3'
    
    #融云(2017年4月14日更新)==融云聊天IMLib界面组件（2017年8月24日）
    pod 'RongCloudIM/IMLib', '2.8.7'

    # 明杰Model
    pod 'MJExtension'
    #网络请求框架
    pod 'AFNetworking', '~> 3.1.0'
    
    #图片解析（不支持gif）
    #pod 'SDWebImage', '~>4.0.0-beta2'
    
    #图片解析支持gif，4.0后不在支持git，请慎重选择
    pod 'SDWebImage', '~>3.8'
    
    #布局
    pod 'Masonry', '~> 1.0.2’
    
    #阿里百川SDK，打开淘宝跳转到商品详情source不能删除
    source 'http://repo.baichuan-ios.taobao.com/baichuanSDK/AliBCSpecs.git'
    pod 'AlibcTradeSDK'
#    pod 'AlibcCouponComponent'#电商组件，提供给三方开发者便捷电商能力，目前提供 优惠券组件，具有领取和查询功能。（废弃）

    #音频在线播放 3.7.2(2017.6.7)
    pod 'FreeStreamer', '~> 3.5.4'
    
#    开屏广告、启动广告解决方案-支持静态/动态图片广告,mp4视频广告,全屏/半屏广告、兼容iPhone/iPad.
#1.如果发现pod search XHLaunchAd 搜索出来的不是最新版本，需要在终端执行cd ~/desktop退回到desktop，然后执行pod setup命令更新本地spec缓存（需要几分钟），然后再搜索就可以了（此方法无效）
#2.如果你发现你执行pod install后,导入的不是最新版本,请删除Podfile.lock文件,在执行一次 pod install
#3.如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
#2017.10.18 -- v3.8.0(强制加上版本号，否则更新不到最新的)
    pod 'XHLaunchAd', '~> 3.8.1'
    

end
