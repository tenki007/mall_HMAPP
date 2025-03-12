import { CartItem, clearCart, deleteCartItem,
  generateConfirmOrder,
  getCartItemList, HmCardItem,
  HmCartItem,
  isLogin, upCartItemQuantity
} from 'basic';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Cart {
  @State isLoading: boolean = false // 是否显示加载动画
  @State refreshStatus: RefreshStatus = RefreshStatus.Inactive // 刷新状态
  @State CartItemList: CartItem[] = [] // 默认数据列表
  @State selectedList: number[] = [] // 选中数据列表
  @State isLogin: boolean = false // 是否登陆
  @State isSelectAll: boolean = true // 是否全选
  @State totalPrice: number = 0 // 总价

  async aboutToAppear() {
    this.isLogin = await isLogin()
    await this.getCartList()

    for (const element of this.CartItemList) {
      this.selectedList.push(element.id as number)
    }
    this.getTotalPrice()
  }

  build() {
    Column() {
      Text("购物车")
        .lineHeight(26)
        .padding({ bottom: 10 })
        .fontWeight(FontWeight.Bold)
      Stack({ alignContent: Alignment.Bottom }) {
        Refresh({ refreshing: $$this.isLoading, builder: this.getRefreshDisPlay }) {
          if (this.CartItemList.length) {
            Column() {
              ForEach(this.CartItemList, (item: CartItem, i: number) => {
                Stack({ alignContent: Alignment.TopStart }) {
                  HmCartItem({
                    item: item,
                    onQuantityChange: (item) => {
                      this.upCartItemQuantity(item)
                    },
                    onDelete: (item) => {
                      this.delCartItem(item)
                    }
                  })
                  Checkbox({ name: item.id?.toString(), group: "itemGroup" })
                    .select(true)
                    .selectedColor($r('app.color.btn_color_2'))
                }

                if (i !== this.CartItemList.length - 1) {
                  Divider()
                }

              }, (item: CartItem) => item.id?.toString())
            }
            .height("100%")
          } else {
            // 空 或 未登陆
            Row() {
              Column() {
                Image($r("app.media.emptyCart"))
                  .width("30%")
                  .margin({ bottom: 15 })
                Text() {
                  Span("空空如也 ")
                    .fontColor($r('app.color.text_normal'))
                  if (this.isLogin) {
                    Span("随便逛逛>")
                      .fontColor($r('app.color.btn_color_2'))
                      .onClick((event) => {
                        router.replaceUrl({ url: "pages/Index" })
                      })
                  } else {
                    Span("去登陆>")
                      .fontColor($r('app.color.btn_color_2'))
                      .onClick((event) => {
                        router.pushUrl({ url: "pages/Login/Login" })
                      })
                  }
                }
                .fontSize(12)
              }
            }
            .height("100%")
          }
        }
        .layoutWeight(1)
        .onStateChange(async (state) => {
          this.refreshStatus = state // 获取状态
          // RefreshStatus.Refresh : 进入刷新状态
          if (state === RefreshStatus.Refresh) {
            // 松手加载
            this.CartItemList = []
            await this.getCartList() // 调用刷新方法
            this.isLoading = false // 关闭下拉的动画效果
            // 下拉刷新意味着所有数据全都不要 重新来过
          }
        }) // 监听下拉刷新的状态\

        // 底部按钮
        if (this.CartItemList.length) {
          this.getBottomBuilder()
        }
      }
      .layoutWeight(1)
    }
  }

  // 修改购物车中指定商品的数量
  async upCartItemQuantity(item: CartItem) {
    await upCartItemQuantity(item)
    await this.getCartList()
    this.getTotalPrice()
  }

  // 删除购物车中指定商品
  async delCartItem(item: CartItem) {
    await deleteCartItem(item.id as number)
    await this.getCartList()
    this.getTotalPrice()
  }

  // 获取购物车中商品的总价
  getTotalPrice() {
    if (this.selectedList.length == 0) {
      this.totalPrice = 0
    } else {
      generateConfirmOrder(this.selectedList).then((res) => {
        this.totalPrice = res.calcAmount?.payAmount as number
      })
    }
  }

  // 获取购物车列表
  async getCartList() {
    if (this.isLogin) {
      this.CartItemList = await getCartItemList()
    }
  }

  // 下拉刷新的展示内容
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

  // 动态生成文本
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

  // 底部按钮
  @Builder
  getBottomBuilder() {
    Row() {
      Stack({ alignContent: Alignment.Start }) {
        if (this.isSelectAll) {
          Button("清空")
            .type(ButtonType.Normal)
            .width(50)
            .height(24)
            .offset({ x: 22 })
            .backgroundColor($r('app.color.box_bottom_line'))
            .borderRadius({ topRight: "50%", bottomRight: "50%" })
            .padding({
              left: 10,
              right: 10,
              top: 0,
              bottom: 0
            })
            .fontSize(14)
            .onClick((event: ClickEvent) => {
              clearCart()
              this.CartItemList = []
            })
        }
        CheckboxGroup({ group: "itemGroup" })
          .width(24)
          .height(24)
          .selectedColor($r('app.color.btn_color_2'))
          .onChange((itemName: CheckboxGroupResult) => {
            itemName.status == 0 ? this.isSelectAll = true : this.isSelectAll = false
            this.selectedList = []
            for (const element of itemName.name) {
              this.selectedList.push(parseInt(element))
            }
            this.getTotalPrice()
          })
      }

      Text("￥" + this.totalPrice + "元")
        .textAlign(TextAlign.End)
        .layoutWeight(1)
      Button("去结算")
        .margin({ left: 15 })
        .enabled(this.selectedList.length > 0)
        .backgroundColor($r('app.color.btn_color_2'))
        .onClick((event: ClickEvent) => {
          router.pushUrl({ url: "pages/Cart/orderset", params: { ids: this.selectedList } })
        })
    }
    .width("90%")
    .height(50)
    .padding({
      left: 15,
      right: 15,
      top: 7,
      bottom: 7
    })
    .backgroundColor("#e8ffffff")
    .shadow({
      radius: 20,
      color: $r('app.color.text_normal_3')
    })
    .borderRadius(8)
    .margin({ bottom: 25 })
  }
}

export default Cart
