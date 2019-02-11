## 如果必要, 先则设置代理，chocolatey会使用代理:
set HTTP_PROXY=http://user:password@proxy.mycompany.com:1234
set HTTPS_PROXY=http://user:password@proxy.mycompany.com:1234

## 安装包管理工具:chocolatey
https://chocolatey.org/install#non-administrative-install

## 安装必须程序: cmake git python ninja等
choco install cmake git python ninja dtc-msys2 gperf
