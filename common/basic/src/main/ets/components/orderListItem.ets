import { kv, OmsOrderItem, OrderDetail } from '../models/order'

@Preview
@Component
struct orderListItem{
  @Prop status:number//0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单
  @Prop item:OrderDetail
  stas:string[]= ['等待付款','等待发货','已发货','已完成','已关闭']
  @State totalnum:number=0
  build() {
      Column(){
        Row(){
          Text(this.item.createTime?.toLocaleString()).fontSize(16).height(40)
          if (this.status!==5){
            Text(this.stas[this.status]).fontSize(18).height(40).fontColor($r('app.color.login_btn_red'))
          }
        }.width('100%')
        .padding({left:10,right:10})
        .justifyContent(FlexAlign.SpaceBetween)
        Divider()
        if (this.item.orderItemList&&this.item.orderItemList.length) {
          ForEach(this.item.orderItemList,(item:OmsOrderItem)=>{
            Row({space:8}) {
              Column({space:5}) {
                Image(item.productPic).size({width:70,height:70})
              }.width("20%")
              Column() {
                Text(item.productName).maxLines(1).textOverflow({overflow:TextOverflow.Ellipsis}).fontSize(18)
                  .fontColor($r('app.color.black'))
                Row(){
                  Text(this.attrToString(item.productAttr)+'x'+item.productQuantity)
                    .fontSize(18)
                    .fontColor($r('app.color.text_normal'))
                }
                Text("￥"+item.productPrice).fontSize(16)
                  .fontColor($r('app.color.black'))
              }.padding(10)
              .width('80%')
              .alignItems(HorizontalAlign.Start)
            }.width('100%')
            .padding(4)
            .justifyContent(FlexAlign.Start)

          })
        }
        Row(){
          Text("共 "+this.item.orderItemList?.length+" 件商品 实付款")
          Text('￥'+this.item.payAmount).fontSize(19)
        }.width('100%')
        .margin({bottom:8})
        .justifyContent(FlexAlign.End)
      }.width('100%')
      .backgroundColor($r('app.color.white'))
      .borderRadius(5)
      .margin({bottom:8})
  }

  attrToString(atrr:string){
    let res:string=''
    let atjs:Array<kv> = JSON.parse(atrr)
    atjs.forEach(item => {
      res=res+item.key+':'+item.value+';'
    });
    return res
  }
}
export {orderListItem}