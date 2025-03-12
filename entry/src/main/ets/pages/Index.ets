import { routerParams, TabClass } from 'basic'
import Cart from './Cart/Cart'
import Cate from './Cate/Cate'
import My from './My/My'
import { router } from '@kit.ArkUI'
import Home from './Home/home'

@Entry
@Component
struct Index {
  @State tabsData: TabClass[] = [{
    title: '首页',
    name: 'home',
    icon:$r("app.media.tab_home"),
    currenticon:$r("app.media.tab_home_current")
  },{
    title: '分类',
    name: 'cate',
    icon:$r("app.media.tab_cate"),
    currenticon:$r("app.media.tab_cate_current")
  },{
    title: '购物车',
    name: 'cart',
    icon:$r("app.media.tab_cart"),
    currenticon:$r("app.media.tab_cart_current")
  },{
    title: '我的',
    name: 'my',
    icon:$r("app.media.tab_my"),
    currenticon:$r("app.media.tab_my_current")
  }]
  @State currentIndex: number = 3 // 当前激活项
  @Provide currentName: string = "" // 当前用户姓名


  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: $$this.currentIndex }) {
        ForEach(this.tabsData, (item: TabClass) => {
          TabContent() {
            if (item.name === 'home') {
              Home()
            } else if (item.name === 'cate') {
              Cate()
            } else if (item.name === 'cart') {
              Cart()
            } else {
              My()
            }
          }.tabBar(this.getTabBar(item))
        })
      }

    }
    .height('100%')
    .width('100%')
  }


  // 标签栏样式
  @Builder
  getTabBar(item: TabClass) {
    Column() {
      Image(item.name === this.tabsData[this.currentIndex].name ?item.currenticon:item.icon)
        .width(22)
        .height(22)
      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .margin({ top: 5 })
        .fontColor(item.name === this.tabsData[this.currentIndex].name ?
        $r('app.color.btn_red') : $r('app.color.btn_gary'))
    }.alignItems(HorizontalAlign.Center)
  }
}