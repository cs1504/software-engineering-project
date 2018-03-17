
数据库设计参考 WordPress 的数据库，以及网上其他相关资料。


table - admin（管理员）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 | 
| 登录名 | loginname |  varchar(20) | 唯一，索引 |
| 昵称 |  nickname | varchar(255) |  索引 |
| 密码 |  password | varchar(255) | md5加密 |
| 手机 | phone | varchar(11) | 唯一，索引 |
| email | email | varchar(255) | 唯一，索引 |
| 角色 | role | tinyint(1) | 是否是超级管理员 |
| 注册时间 | register_time | DATETIME | 年月日时分秒，自动生成 |
| status | status | tinyint(1) | 是否被关闭 |
| 头像 | avatar | varchar(255) | 存储一个地址 |

用户名、手机、邮箱。登录时用正则匹配判断用户登录的方式（初级阶段只需要用户名登录即可）

bigint 这里不是很懂为什么，参考 WordPress 的数据库。

这里说一下密码的加密方式

密码明文：123456  
密码明文连接一个字符串museum：museum123456  
进行 md5 加密（32位小写，函数库直接调用就可以，自己找一下使用方法）：fe386210f3e642fe7ae8931bbede6fa9  


table - user（用户）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 | 
| 登录名 | loginname |  varchar(20) | 唯一，索引 |
| 昵称 |  nickname | varchar(255) |  索引 |
| 密码 |  password | varchar(255) | md5加密 |
| 手机 | phone | varchar(11) | 唯一，索引 |
| email | email | varchar(255) | 唯一，索引 |
| qq | qq | varchar(255) | 唯一，索引 |
| wechat | wechat | varchar(255) | 唯一，索引 |
| 注册时间 | register_time | DATETIME | 年月日时分秒，自动 |
| status | status | tinyint(1) | 是否被关闭 |
| 头像 | avatar | varchar(255) | 存储一个地址 |

table - audio（讲解）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 | 
| 用户id | user_id | bigint(20) | 索引，外键（user.id） |
| 博物馆 id | musemu_id | bigint(20) | 外键（musume.id），索引 |
| 状态 | status | tinyint(1) | 审核是否通过 | 
| 上传时间 | upload_time | DATETIME | 年月日时分秒，自动 |
| 审核通过时间 | pass_time | DATETIME | 年月日时分秒，自动 |
| 地址 | addr | varchar(255) | |
| 描述 | description | text | |
| 文本 | totext | text | 语音转文本的服务（后期添加）|


table - star（打分）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 | 
| 用户id | user_id | bigint(20) | 索引，外键（user.id）非必须 |
| 评论id | comment_id | bigint(20) | 外键（comment.id）非必须 |
| 博物馆 id | musemu_id | bigint(20) | 外键（musume.id），索引，必须的 |
| 展览 | exhibition_star | tinyint(1) | |
| 服务 | service_star | tinyint(1) | | 
| 环境 | environment_star | tinyint(1) | |


table - museum（博物馆）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id |  id | bigint(20) | 自增，唯一，索引 |
| 博物馆名 | name | varchar(255) | 索引 |
| 基本介绍 | introduce | text | |
| 开放时间 | open_time | text | |
| 教育活动 | edu_activity | text | |
| 经典藏品信息 | collection | text | |
| 学术研究信息 | academic | text | |
| 经度 | lng | double(10,6) | 谷歌推荐（小数点后六位，前4位） | 
| 纬度 | lat | double(10,6) | 谷歌推荐（小数点后六位，前4位） |


table - exhibition（展览）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 |
| 博物馆 id | musemu_id | bigint(20) | 外键（musume.id），索引 |
| 展览名称 | name | varchar(255) | 索引 | 
| 展览时间 | time | text | |
| 展览地点 | address | varchar(255) | |
| 展览介绍 | introduce | text | |


table - news（新闻）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 |
| 新闻标题 | title | varchar(255) | 非空，索引 |
| 作者 | author | varchar(255) | 索引，若空则表示来源于网络 |
| 发布时间 | release_time | datetime | 年月日时分秒，未知补零 |
| 修改时间 | modify_time | datetime | 年月日时分秒 |
| 摘要 | excerpt | text | |
| 新闻正文 | content | text | | 
| 新闻状态 | status | tinyint(1) | 是否发布 | 
| 新闻性质 | nature | tinyint(1) | 正面负面 |
| 评论状态 | comment_status | tinyint(1) | 是否可以评论 |


table - news_relationships (新闻与博物馆关系表)

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| 新闻id | news_id | bigint(20) | 索引，外键（news.id） |
| 博物馆id | museum_id | bigint(20) | 索引，外键（museum.id） | 


table - comment（评论）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 |
| option | option | tinyint(1) | 评论博物馆？文章？讲解？ |
| 评论者id | user_id | bigint(20) | 索引，外键（user.id） |
| 评论者IP | user_ip | varchar(255) | |
| 评论时间 | date | datetime | 自动生成 | 
| 评论正文 | content | text | |
| 评论状态 | status | tinyint(1) | |
| 评论父级 | parent | bigint(20) | 外键（comment.id） |

---

以下表可有可无


table - taxonomy（新闻分类方法）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| 类别id | id | bigint(20) | 自增，唯一，索引 |
| 类别 | taxonomy | varchar(255) | 分类、标签？ |
| 描述 | description | varchar(255) | |
| 父级id | parent | bigint(20) | |


table - term_relationships（补充的新闻分类）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| 新闻id |  news_id | bigint(20) | 唯一，索引 | 
| 分类方法id | taxonomy_id | bigint(20) | |


table - options（可选的设置选项）

| 内容 | 字段名 | 类型及大小 | 备注 | 
| --- | --- | --- | --- |
| id | id | bigint(20) | 自增，唯一，索引 |
| 键名 | option_name | varchar(255) | |
| 键值 | option_value | varchar(255) | |
| 自动加载 | autoload | tinyint(1) | |
