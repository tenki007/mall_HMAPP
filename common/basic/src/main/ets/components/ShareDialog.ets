import { TabClass } from "../models"
import { promptAction } from "@kit.ArkUI"


@CustomDialog
@Component
export struct ShareDialog {
  controller?: CustomDialogController
  @State showFlag: Visibility = Visibility.Visible;
  tabData: TabClass[] = [
    {
      title: "微信好友",
      icon: $r("app.media.share_wechat"),
      onRightClick: () => {
        promptAction.showToast({
          message: "分享给微信好友",
          alignment: Alignment.Center
        })
      }
    },
    {
      title: "朋友圈",
      icon: $r("app.media.share_moment"),
      onRightClick: () => {
        promptAction.showToast({
          message: "分享到朋友圈",
          alignment: Alignment.Center
        })
      }
    },
    {
      title: "QQ好友",
      icon: $r("app.media.share_qq"),
      onRightClick: () => {
        promptAction.showToast({
          message: "分享给QQ好友",
          alignment: Alignment.Center
        })
      }
    },
    {
      title: "QQ空间",
      icon: $r("app.media.share_qqzone"),
      onRightClick: () => {
        promptAction.showToast({
          message: "分享到QQ空间",
          alignment: Alignment.Center
        })
      }
    }
  ]
  cancel() {
    this.showFlag = Visibility.Hidden;

    setTimeout(() => {
      this.controller?.close();
    }, 1000);
  }
  build() {
    Column() {
      Row() {
        Row().layoutWeight(1).height(2).backgroundColor($r("app.color.divider"))
        Text("分享到")
          .width(100)
          .textAlign(TextAlign.Center)
        Row().layoutWeight(1).height(2).backgroundColor($r("app.color.divider"))
      }
      .padding({
        left: 16,
        right: 16,
        top: 16,
        bottom: 16
      })

      Grid() {
        ForEach(this.tabData, (v: TabClass) => {
          GridItem() {
            this.item(v)
          }
        })
      }
      .width("100%")
      .height(190)
      .columnsTemplate("1fr 1fr 1fr")
      .rowsTemplate("1fr 1fr")
      .columnsGap(16)
      .rowsGap(10)
      .padding({ left: 16, right: 16 })

      Text("取消")
        .width("100%")
        .height(48)
        .textAlign(TextAlign.Center)
        .borderWidth({ top: 1 })
        .borderColor($r("app.color.divider"))
        .onClick(() => {
          this.cancel()
        })
    }.visibility(this.showFlag)
    .transition(TransitionEffect.OPACITY
      .animation({ duration: 1000 })
      .combine(
        TransitionEffect
          .translate({ y: 1000 })
          .animation({ duration: 1000 })))
    .width("100%")
    .backgroundColor($r("app.color.white"))
  }

  @Builder
  item(item: TabClass) {
    Column({ space: 10 }) {
      Image(item.icon)
        .width(30)
      Text(item.title)
        .fontSize(14)
        .fontColor($r("app.color.text_normal_3"))
    }
    .width(100)
    .height(80)
    .padding({ top: 16 })
    .onClick((event) => {
      if (item.onRightClick) {
        item.onRightClick()
        this.cancel()
      }
    })
  }
}