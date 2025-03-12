import { getAllCateList, PmsProductCategoryNode } from "basic"
import { router } from "@kit.ArkUI"


@Component
struct Cate{

  @State leftList:PmsProductCategoryNode[]=[]
  @State gridList:PmsProductCategoryNode[]=[]
  @State currentId:number = -1

  async aboutToAppear() {
    this.leftList= await getAllCateList()
    this.currentId=this.leftList[0].id?this.leftList[0].id:-1
    this.gridList=this.leftList[0].children?this.leftList[0].children:[]
  }

  @Builder
  leftItem(item:PmsProductCategoryNode){
      Row(){
        if (this.currentId==item.id){
          Image($r('app.media.left_L')).size({height:35})
        }
        Text(item.name).width("100%")
          .fontSize(15)
          .fontColor(this.currentId==item.id?$r('app.color.btn_color_2'):$r('app.color.black'))
          .textAlign(TextAlign.Center)
      }.width('100%')
      .backgroundColor(this.currentId==item.id?$r('app.color.page_bcg'):$r('app.color.white'))
      .justifyContent(FlexAlign.Center)
      .height(60)
    .onClick(()=>{
      this.currentId=item.id?item.id:-1
      this.gridList=item.children?item.children:[]
    })
      .padding(10)
  }

  @Builder
  gridItem(item:PmsProductCategoryNode){
    GridItem(){
      Column(){
        Image(item.icon).width("32%")
        Text(item.name).width("32%").textAlign(TextAlign.Center)
          .fontSize(14)
      }.backgroundColor($r('app.color.white'))
      .justifyContent(FlexAlign.Center)
    }.onClick(()=>{
      router.pushUrl({url:"pages/Cate/CateDetail",params:{id:item.id}})
    })
  }

  build() {
    Row({space:10}){
      Column(){
        ForEach(this.leftList,(item:PmsProductCategoryNode)=>{
          this.leftItem(item)
        })
      }.width("30%")
      .height('100%')
      .backgroundColor($r('app.color.white'))

      Column(){
        Column(){
          Grid(undefined,{regularSize:[3,3]}){
            ForEach(this.gridList,(item:PmsProductCategoryNode)=>{
              if (item.icon) {
                this.gridItem(item)
              }
            })
          }
        }.backgroundColor($r('app.color.white'))
        .width("70%")
        .margin({top:15})
        .borderRadius(5)
      }.height('100%')


    }.backgroundColor($r('app.color.page_bcg'))
    .height('100%')

  }
}



export default Cate