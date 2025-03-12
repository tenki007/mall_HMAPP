import { getHomeContent, getHotProductList,
  getRecommendProductList,
  HomeContentResult, PmsBrand, PmsProduct, SmsHomeAdvertise } from "basic"
import { router } from "@kit.ArkUI"
import Productdetail from "basic/src/main/ets/components/Productdetail"


@Entry
@Component
struct Home {
  @State isLoading: boolean = false // 是否显示加载动画
  @State refreshStatus: RefreshStatus = RefreshStatus.Inactive // 刷新状态
  @State LoadingText: string = "加载中。。。"
  @State currentIndex: number = 0 // 轮播图
  @State pageNum: number = 1 // 当前页码
  @State pageSize: number = 6 // 每页显示数量
  @State finished:boolean = true
  @State loading:boolean = false
  loadingText: string = "加载中.." // 加载中的文本
  finishText: string = "没有数据啦" // 所有数据加载完成的文本
  @State homeContent:HomeContentResult = {}
  @State recommendProductList:PmsProduct[] = []
  swiperController: SwiperController = new SwiperController() // 轮播控制器


  async aboutToAppear(){
    this.homeContent= await getHomeContent()
    this.recommendProductList = await getRecommendProductList(this.pageNum,this.pageSize)
    if ((await getRecommendProductList(this.pageNum, this.pageSize) as PmsProduct[]).length < 6) {
      this.finished=true
    }else {
      this.pageNum++
      this.finished=false
    }
  }

  getData(){
    getRecommendProductList(this.pageNum,this.pageSize).then((res)=>{
      this.recommendProductList.push(...res)
      if (res.length < 6) {
        this.finished=true
      }else {
        this.pageNum++
        this.finished=false
      }
    })

  }

  @Builder
  brandNavbar(){
    Row(){
      Row({space:10}){
        Image($r('app.media.icon_home_brand')).size({height:45})
        Column({space:5}){
          Text('品牌制造商直供').fontSize(20)
          Text('工厂直达消费者，剔除品牌溢价').fontSize(13).fontColor($r('app.color.text_normal'))
        }.alignItems(HorizontalAlign.Start)
      }
      Image($r('app.media.icon_right_svg')).size({height:20})
    }.height(70)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
    .padding(15)
    .onClick(()=>{
        router.pushUrl({url:"pages/Home/brand"})
    })
  }
  @Builder
  recommendNavbar(){
    Row(){
      Row({space:10}){
        Image($r('app.media.icon_recommend_product')).size({height:45})
        Column({space:5}){
          Text('猜你喜欢').fontSize(20)
          Text('你喜欢的都在这里了').fontSize(13).fontColor($r('app.color.text_normal'))
        }.alignItems(HorizontalAlign.Start)
      }
    }.height(70)
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.white'))
    .padding(15)

  }
  @Builder
  newProductNavbar(){
    Row(){
      Row({space:10}){
        Image($r('app.media.icon_new_product')).size({height:45})
        Column({space:5}){
          Text('新鲜好物').fontSize(20)
          Text('为你寻觅世间好物').fontSize(13).fontColor($r('app.color.text_normal'))
        }.alignItems(HorizontalAlign.Start)
      }
      Image($r('app.media.icon_right_svg')).size({height:20})
    }.height(70)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
    .padding(15)
    .onClick(()=>{
        router.pushUrl({url:"pages/Home/newProduct"})
    })
  }
  @Builder
  hotProductNavbar(){
    Row(){
      Row({space:10}){
        Image($r('app.media.icon_new_product')).size({height:45})
        Column({space:5}){
          Text('人气推荐').fontSize(20)
          Text('大家都赞不绝口的').fontSize(13).fontColor($r('app.color.text_normal'))
        }.alignItems(HorizontalAlign.Start)
      }
      Image($r('app.media.icon_right_svg')).size({height:20})
    }.height(70)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
    .padding(15)
    .onClick(()=>{
        router.pushUrl({url:"pages/Home/hotProduct"})
    })
  }
  @Builder
  PromotionBar(){
    Row(){
      Row({space:10}){
        Image($r('app.media.icon_flash_promotion')).size({height:45})
        Column({space:5}){
          Text('秒杀专区').fontSize(20)
          Text('下一场'+this.homeContent.homeFlashPromotion?.nextStartTime?.toDateString()+'开始').fontSize(13).fontColor($r('app.color.text_normal'))
        }.alignItems(HorizontalAlign.Start)
      }
      Column(){
        Text('本场结束剩余：').fontSize(13)
          .fontColor($r('app.color.text_normal'))
        Text('NaN:NaN:NaN').fontSize(20)
          .fontColor($r('app.color.black'))
      }
      .alignItems(HorizontalAlign.Center)
    }.height(70)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
    .padding(15)
    .onClick(()=>{
        router.pushUrl({url:"pages/Home/brand"})
    })
  }
  //品牌图
  @Builder
  gridItem(item:PmsBrand){
    Column({space:5}){
      Image(item.logo).height(55)
      Text(item.name)
      Text('商品数量'+item.productCount).fontSize(13)
        .fontColor($r('app.color.text_normal'))
    }.height(120)
    .padding({top:10,left:8})
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.white'))
    .width('50%')
    .onClick(()=>{
        router.pushUrl({url:"pages/Home/brandDetail",params:{id:item.id}})
    })
  }
  // 轮播图
  @Builder
  carouselBud(items: SmsHomeAdvertise[]) {
    Stack({ alignContent: Alignment.Bottom }) {
      Column()
        .height(180)
        .width('100%')
        .margin({ bottom: 10 })
        .backgroundColor(this.currentIndex % 2 == 1 ? "#cdd7da" : "#cb573c")
        .onClick((event) => {
          AlertDialog.show({ message: JSON.stringify(items) })
        })
      Swiper(this.swiperController) {
        ForEach(items, (v: SmsHomeAdvertise) => {
          Image(v.pic)
            .width("92%")
        })
      }
      .borderRadius(8)
      // .autoPlay(true) // 自动播放
      .interval(5000) // 时间间隔
      .indicator(false) // 是否显示导航
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Row() {
        // 当前页码
        Text((this.currentIndex + 1).toString())
          .width(16)
          .height(16)
          .textAlign(TextAlign.Center)
          .fontSize(12)
          .fontColor($r('app.color.white'))
          .backgroundColor($r('app.color.text_normal_05t'))
          .borderRadius("50%")
        Text("/")
          .height(10)
          .textAlign(TextAlign.Center)
          .fontSize(10)
          .fontColor($r('app.color.white'))
          .backgroundColor($r('app.color.text_normal_05t'))
        // 总页码
        Text(items.length + "")
          .width(16)
          .height(16)
          .textAlign(TextAlign.Center)
          .fontSize(12)
          .fontColor($r('app.color.white'))
          .backgroundColor($r('app.color.text_normal_05t'))
          .borderRadius("50%")
      }
      .width(300)
      .padding({ left: 15, right: 10, bottom: 5 })
    }
    .height(180)
    .margin({ top: 40 })
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

  //专题话题优选特惠
  @Builder
  getCs(){
    Row({space:10}){
      Column(){
        Image($r('app.media.c3')).size({width:50,height:50})
        Text('专题')
      }
      Column(){
        Image($r('app.media.c5')).size({width:50,height:50})
        Text('专题')
      }
      Column(){
        Image($r('app.media.c6')).size({width:50,height:50})
        Text("优选")
      }
      Column(){
        Image($r('app.media.c7')).size({width:50,height:50})
        Text('特惠')
      }
    }.width('100%')
    .backgroundColor($r('app.color.white'))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({left:30,right:30,top:5,bottom:5})
  }

  build() {
      Stack({alignContent:Alignment.Top}){
        Refresh({ refreshing: $$this.isLoading, builder: this.getRefreshDisPlay }){
          List({space:8}){
            if (this.homeContent){
              ListItem(){
                if (this.homeContent.advertiseList) {
                  this.carouselBud(this.homeContent.advertiseList)
                }
              }
              ListItem(){
                this.getCs()
              }
              ListItem(){
                Column(){
                  this.brandNavbar()
                  if (this.homeContent.brandList) {
                    Grid(){
                      ForEach(this.homeContent.brandList,(item:PmsBrand)=>{
                        this.gridItem(item)
                      })
                    }
                  }
                }
              }
              ListItem(){
                this.PromotionBar()
              }
              ListItem(){
                Column(){
                  this.newProductNavbar()
                  Scroll(){
                    Row(){
                      ForEach(this.homeContent.newProductList,(item:PmsProduct)=>{
                        Column(){
                          Productdetail({ImageStr:item.pic,name:item.name,detailtext:item.subTitle,price:item.price,sale:item.sale})
                        }.width('45%')
                        .onClick(()=>{
                          router.pushUrl({url:"pages/Home/Product/ProductDetail",params:{id:item.id}})
                        })
                      })
                    }
                  }.width('100%')
                  .scrollable(ScrollDirection.Horizontal) // 横向滚动
                }
              }.backgroundColor($r('app.color.white'))
              ListItem(){
                Column(){
                  this.hotProductNavbar()
                  List(){
                    ForEach(this.homeContent.hotProductList,(item:PmsProduct)=>{
                      ListItem(){
                        this.hotProductItem(item)
                      }.width('100%')
                      .onClick(()=>{
                        router.pushUrl({url:"pages/Home/Product/ProductDetail",params:{id:item.id}})
                      })
                      .backgroundColor($r('app.color.white'))
                    })
                  }
                }
              }
              ListItem(){
                Column(){
                  this.recommendNavbar()
                  Grid(){
                    ForEach(this.recommendProductList,(item:PmsProduct)=>{
                      GridItem(){
                        Productdetail({showYS:false,ImageStr:item.pic,name:item.name,detailtext:item.subTitle,price:item.price,sale:item.sale})
                      }.width("50%")
                      .margin({bottom:50})
                      .onClick(()=>{
                        router.pushUrl({url:"pages/Home/Product/ProductDetail",params:{id:item.id}})
                      })
                    })
                  }.backgroundColor($r('app.color.white'))

                }.justifyContent(FlexAlign.Start)
                .backgroundColor($r('app.color.white'))
              }
              ListItem(){
                Text(this.finished?this.finishText:this.loadingText)
                  .fontSize(14).fontColor($r('app.color.text_normal'))
                  .width('100%').textAlign(TextAlign.Center)
                  .height(50)
              }
            }

          }.height('100%')
          .backgroundColor($r('app.color.page_bcg'))
          .onReachEnd(()=>{
            if (!this.finished&&!this.loading) {
              this.loading=true
              this.getData()
              this.loading=false
            }
          })
        }.onStateChange(async (state) => {
          this.refreshStatus = state // 获取状态
          // RefreshStatus.Refresh : 进入刷新状态
          if (state === RefreshStatus.Refresh) {
            // 松手加载
            this.homeContent= await getHomeContent()
            this.isLoading = false // 关闭下拉的动画效果
          }
        }) // 监听下拉刷新的状态
        .layoutWeight(1)
        this.getSearch()
      }
  }

  //人气推荐item
  @Builder
  hotProductItem(item:PmsProduct){
    Row({space:8}){
      Column(){
        Image(item.pic).height('100%')
      }.width('35%')
      Column({space:15}){
        Row(){
          Text(item.name).fontSize(18)
            .maxLines(1)
            .textOverflow({overflow:TextOverflow.Ellipsis})
        }
        Row(){
          Text(item.subTitle)
            .fontColor($r('app.color.text_normal'))
            .fontSize(13)
            .maxLines(2)
            .textOverflow({overflow:TextOverflow.Clip})
        }
        Row(){
          Text('￥'+item.price).fontColor($r('app.color.login_btn_red')).fontSize(18)
        }
      }.width('60%')
      .alignItems(HorizontalAlign.Start)
    }.justifyContent(FlexAlign.Start)
    .width('100%')
    .height(160)
  }
  //扫码/输入框
  @Builder
  getSearch(){
    Row({space:10}){
      Image($r('app.media.saomiao')).size({width:25})
      Image($r('app.media.search')).size({height:25,width:'60%'})
      Image($r('app.media.message')).size({width:25})
    }.width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .backgroundColor(this.currentIndex % 2 == 1 ? "#cdd7da" : "#cb573c")

  }

}



export default Home