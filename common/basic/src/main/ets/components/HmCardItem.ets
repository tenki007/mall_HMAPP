
@Component
struct HmCardItem {
  onRightClick: () => void = () => {}
  leftTitle: string = ''
  showBottomBorder: boolean = true
  showRightIcon: boolean = true
  leftIcon:ResourceStr = ''
  @Prop rightText: string
  build() {
    Row() {
      Row(){
        if (this.leftIcon!==''){
          Image(this.leftIcon).width(24).height(24).margin({right:8})
        }
        Text(this.leftTitle).fontSize(13).fontWeight(400).fontColor($r('app.color.black'))
      }.padding(5)
      Row() {
        if (this.rightText) {
          Text(this.rightText).fontColor($r("app.color.text_normal")).fontWeight(400).fontSize(14)
        }
        if (this.showRightIcon) {
          Image($r("app.media.icon_arrow_right")).width(15).height(15)
        }
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.onRightClick()
    })
    .border({
      width: {
        bottom: this.showBottomBorder ? 1 : 0
      },
      color:
      $r('app.color.tabs_item_normal')
    })
    .width('100%')
    .height(53)
  }
}
export { HmCardItem }