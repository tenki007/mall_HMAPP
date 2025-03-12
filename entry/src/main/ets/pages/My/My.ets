import { authRouter, CardItemClass , HmCard, HmCardItem, UserSettings} from 'basic'
import { router } from '@kit.ArkUI'

@Component
struct My {
  @State HmCardItemList:CardItemClass[] = [
    {
      onRightClick: () => {
          authRouter("pages/My/Details/address")
        },
      leftTitle: "地址管理",
      rightText: "地址管理",
      leftIcon:$r("app.media.icon_gps")
    },
    {
      onRightClick: () => {},
      leftTitle: '我的足迹',
      leftIcon:$r("app.media.icon_trail"),
      rightText: "我的足迹",
    },
    {
      onRightClick: () => {},
      leftTitle: "我的关注",
      leftIcon:$r("app.media.icon_concern"),
      rightText:"我的关注"
    },
    {
      onRightClick: () => {},
      leftTitle: "我的收藏",
      leftIcon:$r("app.media.icon_collect"),
      rightText:"我的收藏"
    },
    {
      onRightClick: () => {},
      leftTitle: "我的评价",
      leftIcon:$r("app.media.icon_assess"),
      rightText:"我的评价"
    },
    {
      onRightClick: () => {
        router.pushUrl({url:"pages/My/Details/setting"})
      },
      leftTitle: "设置",
      leftIcon:$r("app.media.icon_settings"),
      rightText:"设置",
      showBottomBorder:false
    }
  ]
  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomEnd }) {
        Column() {
          Row({ space: 12 }) {
            Image($r("app.media.icon_message"))
              .width(20)
            Image($r("app.media.icon_set"))
              .width(20)
          }.width("100%")
          .justifyContent(FlexAlign.End)

          Row({ space: 8 }) {
            Image($r("app.media.missing_face"))
              .width(60)
              .borderWidth(1)
              .borderRadius("50%")
              .borderColor($r('app.color.white'))
            Text("游客")
          }
          .width("100%")
          .layoutWeight(1)
          .padding({ top: 20 })

          Row() {
            Text("黄金会员")
              .margin({ left: 22 })
              .fontSize(14)
              .fontColor("#f7d680")
            Text("立即开通")
              .fontSize(12)
          }
          .width("100%")
          .height(40)
          .padding({ left: 15, right: 15 })
          .justifyContent(FlexAlign.SpaceBetween)
        }.height("100%")
        .padding(10)
        .backgroundImage($r("app.media.user_bg"))
        .backgroundImageSize(ImageSize.Cover)

        Image($r("app.media.arc"))
          .width("100%")
      }.height(180)

      Column() {
        Row() {
          Column() {
            Text("暂无")
              .fontSize(18)
              .fontColor($r('app.color.black'))
              .lineHeight(25)
              .margin({bottom:5})
            Text("积分").fontSize(12).fontColor($r('app.color.text_normal')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)

          Column() {
            Text("暂无")
              .fontSize(18)
              .fontColor($r('app.color.black'))
              .lineHeight(25)
              .margin({bottom:5})
            Text("成长值").fontSize(12).fontColor($r('app.color.text_normal')).lineHeight(17)

          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)

          Column() {
            Text("暂无")
              .fontSize(18)
              .fontColor($r('app.color.black'))
              .lineHeight(25)
              .margin({bottom:5})
            Text("优惠券").fontSize(12).fontColor($r('app.color.text_normal')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)
        }
      }.backgroundColor($r("app.color.white"))
      .padding(10)
      .margin({left:15,right:15,bottom:10})
      .borderRadius(5)

      Column() {
        Row() {
          Column() {
            Image($r('app.media.icon_order')).size({width:25,height:25})
              .margin({bottom:5})
            Text("全部订单").fontSize(12).fontColor($r('app.color.black')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)
          .onClick(()=>{
            authRouter("pages/My/Details/order",{currentIndex:0})
          })

          Column() {
            Image($r('app.media.icon_pendingPayment')).size({width:25,height:25})
              .margin({bottom:5})
            Text("待付款").fontSize(12).fontColor($r('app.color.black')).lineHeight(17)

          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)
          .onClick(()=>{
            authRouter("pages/My/Details/order",{currentIndex:1})
          })

          Column() {
            Image($r('app.media.icon_toBeReceived')).size({width:25,height:25})
              .margin({bottom:5})
            Text("待收货").fontSize(12).fontColor($r('app.color.black')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)
          .onClick(()=>{
            authRouter("pages/My/Details/order",{currentIndex:2})
          })

          Column() {
            Image($r('app.media.icon_refund')).size({width:25,height:25})
              .margin({bottom:5})
            Text("退款/售后").fontSize(12).fontColor($r('app.color.black')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)
        }
      }.backgroundColor($r("app.color.white"))
      .padding(20)
      .margin({left:15,right:15})
      .borderRadius(5)

      HmCard(){
        ForEach(this.HmCardItemList,(item:CardItemClass,index)=>{
          HmCardItem({
            leftIcon:item.leftIcon,
            leftTitle:item.leftTitle,
            showBottomBorder:item?.showBottomBorder,
            onRightClick:item.onRightClick
          })
        })
      }
    }.height('100%')
    .width('100%')
    .backgroundColor($r('app.color.page_bcg'))
  }
}
export default My