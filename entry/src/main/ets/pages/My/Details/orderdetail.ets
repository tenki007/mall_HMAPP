import { CommonPageOmsOrderDetail, getAllOrderList, OrderDetail,orderListItem, OrderRequest } from 'basic';

@Component
struct OrderDetailp{
  @Prop currentIndex:number;
  @State status: number = -1
  @State pageNum: number = 1 // 当前页码
  @State pageSize: number = 5 // 每页显示数量
  @State items:CommonPageOmsOrderDetail={}
  @State OrderList: OrderDetail[] = []
  @State isLoading: boolean = false // 是否显示加载动画
  @State refreshStatus: RefreshStatus = RefreshStatus.Inactive // 刷新状态
  @Prop finished: boolean = false // 需要一个标记 还没有数据的标记,是否还有下一页数据
  loadingText: string = "加载中.." // 加载中的文本
  finishText: string = "没有数据啦" // 所有数据加载完成的文本

  addList: OrderDetail[] =[]
  async aboutToAppear() {
    this.OrderList = (await getAllOrderList({pageNum:this.pageNum,pageSize:this.pageSize,status:this.status})).list as OrderDetail[]
  }

  async getData(isRefresh: boolean = true) {

    if (isRefresh) {
      this.pageNum=1
      this.addList = (await getAllOrderList({pageNum:this.pageNum,pageSize:this.pageSize,status:this.status})).list as OrderDetail[]
      this.OrderList = this.addList
    } else {
      this.addList = (await getAllOrderList({pageNum:this.pageNum,pageSize:this.pageSize,status:this.status})).list as OrderDetail[]
      this.OrderList.push(...this.addList)

    }
      if (this.addList.length < 5 ) {
        this.finished = true
      }else {
        this.pageNum++
      }


  }

  build() {
    if (this.OrderList.length > 0) {
    Column() {
      Refresh({ refreshing: $$this.isLoading, builder: this.getRefreshDisPlay }) {
        Column() {
          List() {
            ForEach(this.OrderList, (item1: OrderDetail) => {
              ListItem() {
                orderListItem({ item: item1, status: item1.status })
              }
            })
            ListItem() {
              this.getBottomDisplay()
            }
          }.onReachEnd(async () => {
            if (!this.finished) {
              await this.getData(false)
            }
          })
          .height('100%')
        }
      }.layoutWeight(1)
      .onStateChange(async (state) => {
        this.refreshStatus = state // 获取状态
        // RefreshStatus.Refresh : 进入刷新状态
        if (state === RefreshStatus.Refresh) {
          // 松手加载
          this.OrderList = []
          await this.getData(true) // 调用刷新方法
          this.isLoading = false // 关闭下拉的动画效果
        }
      })
    }.height("100%")
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .backgroundColor($r('app.color.page_bcg'))
  }else {
      Column() {
        Row() {
          Image($r("app.media.no_notify"))
            .width(100)
        }
      }
    }
  }


  @Builder
  getBottomDisplay() {
    // 获取底部的展示内容
    Row({ space: 10 }) {
      if (this.finished) {
        // 此时应该没有动画的loading
        Text(this.finishText)
          .fontSize(14)
      } else {
        Text(this.loadingText)
          .fontSize(14)
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
      }
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }


  @Builder
  getRefreshDisPlay() {
    Row({ space: 10 }) {
      LoadingProgress()
        .width(40)
        .height(40)
      Text(this.getStatusText())
        .fontSize(14)
    }
    .justifyContent(FlexAlign.Center)
    .height(50)
    .width('100%')
  }
  getStatusText() {
    // 根据下拉状态返回不同的文本
    switch (this.refreshStatus) {
      case RefreshStatus.Inactive:
        return ""
      case RefreshStatus.Drag:
        return "继续下拉"
      case RefreshStatus.OverDrag:
        return "松手加载"
      case RefreshStatus.Refresh:
        return "加载中"
    }
    return ""
  }
}

export { OrderDetailp }