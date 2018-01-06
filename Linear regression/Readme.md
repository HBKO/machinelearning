 we use the linear regression for face recognition.
 the dataset is ORL_32_32(the detail is for readme.txt)
 we use hold-out and crossValidation method to do face recognition.
 Linear.m:利用回归判断图片属于哪一类
 Lineartest.m:利用8，2的留出法进行测试，成功率在93%
 crossValidation.m:利用cross validation进行测试，成功率在90%
 Regression.m:测试文件
 costfunction.m:对率回归的目标函数
 logisitic.m:利用牛顿法求解对率回归，准确率有点低。然后，我用网上down的对率回归发觉准确率也比较低。
 这里初步想两个原因：1.数据量太小，就17个数据。2.数据不是线性可分。
 test.m:网上下载下来测试的对率回归程序
 ORL_32_32.mat:ORL人脸数据集
 watermelondata:西瓜数据集
 From 何柯文
 
