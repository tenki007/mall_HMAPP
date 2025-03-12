import { CommonPageOmsOrderDetail, getAllOrderList, HmNavBar, OrderRequest, orderTabClass, routerParams } from 'basic'
import { router } from '@kit.ArkUI'
import { OrderDetailp } from './orderdetail'

@Entry
@Component
struct Order {

  @State @Watch("updateName") currentIndex: number = 0 // 当前激活项
  @Provide currentName: string = "" // 当前名称
  @State tabsData: orderTabClass[] = [
    {
      title: "全部",
      name: "all"
    },
    {
      title: "待付款",
      name: "pay"
    },
    {
      title: "待收货",
      name: "receive"
    },
    {
      title: "已完成",
      name: "complete"
    },
    {
      title: "已取消",
      name: "cancel"
    }
  ]

  aboutToAppear(): void {
    const params = router.getParams() as routerParams
    if (params) {
      if (params.currentIndex) {
        this.currentIndex = params.currentIndex
      }
    }
  }

  build() {
    Column() {
      HmNavBar({ title: "我的订单" })
      Tabs({ barPosition: BarPosition.Start, index: $$this.currentIndex }) {
        ForEach(this.tabsData, (item: orderTabClass) => {
          TabContent() {
            if (item.name === 'all') {
              OrderDetailp({pageNum:1,pageSize:5,status:-1})
            } else if (item.name === 'pay') {
              OrderDetailp({pageNum:1,pageSize:5,status:0})
            } else if (item.name === 'receive') {
              OrderDetailp({pageNum:1,pageSize:5,status:1})
            } else if (item.name === 'complete') {
              OrderDetailp({pageNum:1,pageSize:5,status:3})
            } else if (item.name === 'cancel') {
              OrderDetailp({pageNum:1,pageSize:5,status:4})
            }
          }.tabBar(this.getTabBar(item))
        })
      }
    }
    .height('100%')
    .width('100%')
  }

  // 更新当前名称
  updateName() {
    this.currentName = (this.tabsData[this.currentIndex].name) as string
  }

  // 标签栏样式
  @Builder
  getTabBar(item: orderTabClass) {
    Column() {
      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .margin({ top: 5 })
        .fontColor(item.name === this.tabsData[this.currentIndex].name ?
        $r('app.color.login_btn_red') : $r('app.color.tabs_item_normal'))
      if (item.name === this.tabsData[this.currentIndex].name) {
        Row()
          .height(2)
          .width(36)
          .margin({ top: 5 })
          .backgroundColor($r('app.color.login_btn_red'))
      }
    }.alignItems(HorizontalAlign.Center)
  }
}
export default Order