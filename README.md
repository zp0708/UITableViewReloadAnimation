# UITableViewReloadAnimation
刷新TableView时动画加载cell
######将文件加入项目,导入头文件
<pre><code>
#import "UITableView+Extension.h"
</code></pre>

######需要刷新TableView时使用以下代码即可
<pre><code>
[self.tableView reloadDataWithDirectionType:direction AnimationTimeNum:0.5 interval:0.05];
</code></pre>
