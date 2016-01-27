# ZJFunction 
## 项目常用库 
### ZJNavigationController和ZJTabBarController 
* 1 ZJNavigationController实现手势滑动返回 
* 2 ZJTabBarController实现了在tabBar的显示和隐藏（tabBar.viewControllers显示，其他隐藏）

![](https://raw.githubusercontent.com/zxc3731/ZJPublic/master/tem22.gif) 

### UILabel+LinkLabel 
实现点击UILabel，block回调，类似html的
```html
<a href="****">title</a>
```

### UIImageView+additional.h 
实现点击放大，依赖 MBProgressHUD 

### UIView+additional.h 
实现某边加上border。例如:
```objective-C
    UILabel *temla = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 100, 20)];
    temla.textColor = [UIColor blackColor];
    temla.text = @"测试";
    [self.view addSubview:temla];
    temla.borderWhich = ZJViewBorderBottom|ZJViewBorderRight;
```
![](https://raw.githubusercontent.com/zxc3731/ZJPublic/master/E38C7995-E465-4A07-9306-400BCA5960A5.png) 
