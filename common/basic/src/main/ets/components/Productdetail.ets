@Preview
@Component

struct Productdetail {
  ImageStr:string = "http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg"
  name:string = '华为 HUAWEI P20'
  detailtext:string = 'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待'
  price:number = 3788
  sale:number = 100
  @State showYS:boolean = true
  build() {
    Column({space:5}){
      Image(this.ImageStr).size({width:"100%"})
      Text(this.name).width('100%').fontSize(18)
        .maxLines(1)
        .textOverflow({overflow:TextOverflow.Ellipsis})
      Text(this.detailtext).width('100%')
        .fontColor($r('app.color.text_normal'))
        .fontSize(13)
        .maxLines(2)
        .textOverflow({overflow:TextOverflow.Clip})
      Row(){
        Text('￥'+this.price).fontColor($r('app.color.login_btn_red'))
        if (this.showYS){
          Text('已售 ' + this.sale).fontSize(13).fontColor($r('app.color.text_normal'))
        }
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }.padding(5)
  }
}
export default Productdetail