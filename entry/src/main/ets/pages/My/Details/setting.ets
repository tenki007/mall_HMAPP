import { CardItemClass, HmCard, HmCardItem, HmNavBar, UserSettings } from 'basic';
import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct Setting {
  @State settings:CardItemClass[] = [{
    leftTitle:"个人资料"
  },{
    leftTitle:"收货地址"
  },{
    leftTitle:"实名认证",
    showBottomBorder:false
  }];
  @State settings1:CardItemClass[] = [{
    leftTitle:"清除缓存"
  },{
    leftTitle:"检查更新",
    rightText:"当前版本1.0.0",
    showBottomBorder:false
  }];



  build() {
    Column(){
      HmNavBar({title:"设置"})
      HmCard(){
        ForEach(this.settings,(item:CardItemClass)=>{
          HmCardItem({
            leftTitle:item.leftTitle,
            rightText:item?.rightText,
            showBottomBorder:item?.showBottomBorder
          })
        })
      }

      HmCard(){
        Row(){
          Text("消息推送").fontSize(13).fontWeight(400).fontColor($r('app.color.black'))
          Toggle({type:ToggleType.Switch}).selectedColor($r("app.color.btn_red"))
        }.justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(53)
      }

      HmCard(){
        ForEach(this.settings1,(item:CardItemClass)=>{
          HmCardItem({
            leftTitle:item.leftTitle,
            rightText:item?.rightText,
            showBottomBorder:item?.showBottomBorder
          })
        })
      }

      HmCard(){
        Text("退出登录").height(55)
          .fontColor($r('app.color.btn_red'))
          .onClick(async ()=>{
          promptAction.showDialog({
            message: "确定要退出登录么",
            buttons: [
              { text: "取消", color: "#FF000000" },
              { text: "确定", color: "#FF007AFF" }
            ]
          }).then((result) => {
            if (result.index == 1) {
              new UserSettings((getContext())).setUserToken("")
              router.replaceUrl({ url: "pages/Index" })
            }
          })
        })
      }
    }.height('100%')
    .width('100%')
    .backgroundColor($r('app.color.page_bcg'))
  }
}