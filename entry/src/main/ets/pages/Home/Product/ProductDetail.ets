import {
  addCartItem,
  addCartReqParams,
  getProductCoupons,
  getProductDetail, PmsPortalProductDetail, PmsProduct,
  PmsSkuStock,
  property,
  propertyArr,
  routerParams,
  ShareDialog,
  ShowParamsDialog,
  SmsCoupon,
  SpecsDialog} from 'basic'
import { promptAction, router } from '@kit.ArkUI'
import web_webview from '@ohos.web.webview';


@Entry
@Component
struct ProductDetail {
  @State productId:number = 26
  @State item:PmsPortalProductDetail = {}
  @State Product:PmsProduct = {}
  @State picList:string[] = []
  @State @Watch("upDataProperty") itemProperty: property[] | null = null // 商品规格
  @State itemSkuStock: PmsSkuStock | null = null // 商品规格相关参数
  @State AllProperty: propertyArr[] | null = null // 商品规格
  @State PropertyName: string = "" // 商品规格名称

  controller: web_webview.WebviewController = new web_webview.WebviewController();

  //分享弹窗
  shareCustomDialog = new CustomDialogController({
    builder: ShareDialog(),
    customStyle: true,
    alignment: DialogAlignment.Bottom,

  })
  // 规格选择弹窗控制器
  specsCustomDialog = new CustomDialogController({
    builder: SpecsDialog({
      item: this.item,
      itemProperty: this.itemProperty,
      AllProperty: this.AllProperty,
      itemSkuStock: this.itemSkuStock,
      PropertyName: this.PropertyName,
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  })
  // 查看商品参数弹窗控制器
  showParamsCustomDialog = new CustomDialogController({
    builder: ShowParamsDialog({
      item: this.item,
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  })
  // 分享
  @Builder
  buildShare() {
    Row() {
      Text("★")
        .fontSize(12)
        .padding(1)
        .fontColor($r("app.color.white"))
        .backgroundColor($r("app.color.btn_color_2"))
        .borderRadius({ topRight: 4, bottomRight: 4 })
      Text("返")
        .fontSize(12)
        .padding({ left: 3 })
        .offset({ x: -3 })
        .fontColor($r("app.color.btn_color_2"))
        .borderColor($r("app.color.btn_color_2"))
        .borderRadius(3)
        .borderWidth({ top: 1, bottom: 1, right: 1 })
      Text("该商品分享可领49减10红包")
        .fontSize(14)
        .fontColor($r("app.color.text_normal_3"))
      Text("?")
        .width(12)
        .height(12)
        .fontSize(10)
        .fontColor($r("app.color.text_normal_2"))
        .borderWidth(1)
        .borderRadius("50%")
        .borderColor($r("app.color.text_normal_2"))
        .textAlign(TextAlign.Center)
      Text("立即分享 > ")
        .layoutWeight(1)
        .fontSize(12)
        .textAlign(TextAlign.End)
        .fontColor($r("app.color.btn_color_2"))
    }
    .width("100%")
    .padding({
      top: 8,
      bottom: 8,
      left: 10,
      right: 10
    })
    .borderWidth({ bottom: 1 })
    .borderColor($r("app.color.divider"))
    .onClick((event) => {
      this.shareCustomDialog.open()
    })
  }

  async aboutToAppear() {
    const params: routerParams = router.getParams() as routerParams
    if (params.id) {
      this.productId=params.id
    }
    let res = await getProductDetail(this.productId)
    this.Product=res.product as PmsProduct
    this.item = res
    this.itemSkuStock = (res.skuStockList as PmsSkuStock[])[0] // 商品全部规格
    this.itemProperty =
      JSON.parse((res.skuStockList as PmsSkuStock[])[0].spData as string) as property[]; // 商品规格
    this.PropertyToMenu() // 规格转选项
    this.getSwiperList()

  }


  // 更改选中规格
  upDataProperty() {
    if (this.itemProperty) {
      let str = ""
      for (const e of this.itemProperty as property[]) {
        str += e.value + " "
      }
      this.PropertyName = str

      str = JSON.stringify(this.itemProperty)
      let i = (this.item?.skuStockList as PmsSkuStock[]).findIndex((v) => v.spData == str)
      if (i != -1) {
        this.itemSkuStock = (this.item?.skuStockList as PmsSkuStock[])[i]
      }
    }
  }

  // 全部规格转选项
  PropertyToMenu() {
    let arr: propertyArr[] = []
    let skuStockList = this.item?.skuStockList as PmsSkuStock[]

    for (const item of skuStockList) {
      // 这里item为PmsSkuStock类型下一步取出item里面的spData项并转为property类型
      const itemSpData =
        JSON.parse(item.spData as string) as property[] // [{key:"颜色",value:"黑色"},{key:"容量",value:"128G"}]
      for (let element of itemSpData) {
        // element => {key:"颜色",value:"黑色"}
        let index = arr.findIndex((v) => v.key == element.key)
        if (index != -1) {
          // 存在
          if (!arr[index].value.includes(element.value)) {
            // 不存在
            arr[index].value.push(element.value)
          }
        } else {
          // 不存在
          arr.push({ key: element.key, value: [element.value] })
        }
      }
    }
    this.AllProperty = arr
  }

  getSwiperList(){
    if (this.Product.pic) {
      this.picList.push(this.Product.pic)
    }
    let add = this.Product.albumPics?.split(',') as string[]
    if (add.length) {
      this.picList.push(...add)
    }
  }

  build() {
    Stack({alignContent:Alignment.TopStart}){
      Stack({alignContent:Alignment.Bottom}) {
        Column() {
          List({ space: 10 }) {
            ListItem() {
              Swiper() {
                ForEach(this.picList, (item: string) => {
                  if (item !== '') {
                    Image(item).size({ width: '100%' })
                  }
                })
              }.indicator(
                new DotIndicator()
                  .itemWidth(10)
                  .itemHeight(10)
                  .selectedItemWidth(10)
                  .selectedItemHeight(10)
                  .selectedColor(Color.Black)
              )
            }

            ListItem() {
              Column({ space: 10 }) {
                Text(this.Product.name).fontSize(20)
                Text(this.Product.subTitle).fontSize(17).fontColor($r('app.color.text_normal'))
              }.alignItems(HorizontalAlign.Start)
            }

            ListItem() {
              Row() {
                Text('￥' + this.Product.price + ' ').fontSize(20).fontColor($r('app.color.login_btn_red'))
                Text('￥' + this.Product.originalPrice).fontSize(14)
                  .fontColor($r('app.color.text_normal'))
                  .decoration({ type: TextDecorationType.LineThrough })
              }
            }

            ListItem() {
              Row() {
                Text('销量' + this.Product.sale).fontSize(14).fontColor($r('app.color.text_normal'))
                Text('库存' + this.Product.stock).fontSize(14).fontColor($r('app.color.text_normal'))
                Text('浏览量' + 9999).fontSize(14).fontColor($r('app.color.text_normal'))
              }.width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
            ListItem(){
              Column(){
                this.buildShare()
              }.width('100%').backgroundColor("#f8f8f8")
            }

            // 商品规格及参数
            ListItem() {
              this.buildProductProperty()
            }

            // 评论
            ListItem() {
              this.buildComment()
            }
            .margin({ top: 8 })

            // 品牌信息
            ListItem() {
              this.buildBrand()
            }
            .margin({ top: 8 })


            // 图文详情
            ListItem() {
              this.buildProductDetail()
            }
            .margin({ top: 8 })
          }.onReachEnd(()=>{
            this.controller.loadData(
              "<html>" +
                "<style>" +
                ".wscnph{" +
                "width: 100%;" +
                "}" +
                "</style>" +
                "<body bgcolor=\"white\">" +
                this.item?.product?.detailMobileHtml +
                "</body>" +
                "</html>",
              "text/html",
              "UTF-8"
            );
          })

        }
        .padding(10)
        .height('100%')
        .width('100%')

        Column() {
          this.buildBottomMenu()
        }.width('100%')
        .justifyContent(FlexAlign.End)
        .alignItems(HorizontalAlign.Center)
      }
      Image($r('app.media.back')).size({width:35,height:35})
        .margin(10).onClick(() => {
        router.back() // 回上一页
      })

    }
  }

  // 商品参数及规格
  @Builder
  buildProductProperty() {
    Column() {
      // 购买类型
      Row() {
        Text("购买类型")
          .textTitStyles()
        Text(this.PropertyName)
          .textSubTitStyles()
        Image($r("app.media.icon_right_svg"))
          .width(14)
          .fillColor($r("app.color.text_normal"))
      }
      .RowStyles()
      .onClick((event) => {
        this.specsCustomDialog.open()
      })

      // 商品参数
      Row() {
        Text("商品参数")
          .textTitStyles()
        Text("查看")
          .textSubTitStyles()
        Image($r("app.media.icon_right_svg"))
          .width(14)
          .fillColor($r("app.color.text_normal"))
      }
      .RowStyles()
      .onClick((event) => {
        this.showParamsCustomDialog.open()
      })

      // 优惠券
      Row() {
        Text("优惠券")
          .textTitStyles()
        Text("领取优惠券")
          .textSubTitStyles()
          .fontColor($r("app.color.btn_color_2"))
        Image($r("app.media.icon_right_svg"))
          .width(14)
          .fillColor($r("app.color.text_normal"))
      }
      .RowStyles()
      .onClick((event) => {
        getProductCoupons(this.item?.product?.id as number).then((res) => {
          if (res == [] as SmsCoupon[]) {
            promptAction.showToast({ message: "暂无优惠券" })
          }
        })
      })

      // 促销活动
      Row() {
        Text("促销活动")
          .textTitStyles()
        if (this.item?.productFullReductionList) {
          Column() {
            Text("满减优惠")
              .fontSize(14)
              .fontColor($r("app.color.text_normal_4"))
            Text("满" + this.item.productFullReductionList[0].fullPrice + "元减" +
            this.item.productFullReductionList[0].reducePrice + "元")
              .fontSize(14)
              .fontColor($r("app.color.text_normal_4"))
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        } else {
          Text("暂无优惠")
            .textSubTitStyles()
            .fontColor($r("app.color.btn_color_2"))
        }
      }
      .RowStyles()

      // 服务
      Row() {
        Text("服务")
          .textTitStyles()
        Text(this.getServiceName(this.item?.product?.serviceIds as string))
          .layoutWeight(1)
          .fontSize(14)
          .fontColor($r("app.color.text_normal_4"))
      }
      .RowStyles()
    }
  }

  // 图文详情
  @Builder
  buildProductDetail() {
    Column() {
      Row({ space: 10 }) {
        Row().width(40).height(2).backgroundColor($r("app.color.page_bcg"))
        Text("图文详情").fontSize(14)
        Row().width(40).height(2).backgroundColor($r("app.color.page_bcg"))
      }
      .width("100%")
      .margin({ bottom: 8 })
      .justifyContent(FlexAlign.Center)

      Web({ src: 'www.example.com', controller: this.controller })
    }
    .width("100%")
    .padding({ top: 8, bottom: 8 })
    .backgroundColor($r("app.color.white"))

  }

  // 评论区
  @Builder
  buildComment() {
    Column() {
      Row() {
        Text() {
          Span("评论")
          Span("（86）")
            .fontSize(12)
            .fontColor($r("app.color.text_normal_2"))
        }

        Row().layoutWeight(1)
        Text("好评率 100% ")
          .fontSize(12)
          .fontColor($r("app.color.text_normal_2"))
        Image($r("app.media.icon_right_svg"))
          .width(14)
          .fillColor($r("app.color.text_normal"))
      }
      .padding({
        top: 8,
        bottom: 8
      })

      Column() {
        Text("Leo yo")
          .fontSize(12)
          .margin({ top: 8, bottom: 8 })
        Text("商品收到了，79元两件，质量不错，试了一下有点瘦，但是加个外罩很漂亮，我很喜欢")
          .fontSize(13)
          .lineHeight(16)
          .margin({ top: 8, bottom: 8 })
        Row() {
          Text("购买类型：XL 红色")
            .fontSize(12)
            .fontColor($r("app.color.text_normal_2"))
          Row().layoutWeight(1)
          Text("2025-3-10 13:14")
            .fontSize(12)
            .fontColor($r("app.color.text_normal_2"))
        }
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 60 })
    }
    .width("100%")
    .backgroundColor(Color.White)
    .padding({
      top: 8,
      bottom: 14,
      left: 10,
      right: 10
    })
  }

  // 品牌信息
  @Builder
  buildBrand() {
    Column() {
      Row({ space: 10 }) {
        Row().width(40).height(2).backgroundColor($r("app.color.page_bcg"))
        Text("品牌信息").fontSize(14)
        Row().width(40).height(2).backgroundColor($r("app.color.page_bcg"))
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)

      Row() {
        Image(this.item?.brand?.logo)
          .width("30%")
        Column() {
          Text(this.item?.brand?.name)
            .fontSize(14)
          Text("品牌首字母：" + this.item?.brand?.firstLetter)
            .fontSize(12)
            .lineHeight(20)
            .fontColor($r("app.color.text_normal_2"))
        }
        .padding({ left: 8 })
        .alignItems(HorizontalAlign.Start)
      }
      .width("100%")
      .padding({ left: 18, top: 20, bottom: 8 })
      .justifyContent(FlexAlign.Start)

    }
    .width("100%")
    .padding({ top: 8, bottom: 8 })
    .backgroundColor($r("app.color.white"))
  }
  // 获取服务名称
  getServiceName(serviceIds: string): string {
    let serviceName = "";
    if (serviceIds) {
      let serviceIdsArr = serviceIds.split(",");
      for (let i = 0; i < serviceIdsArr.length; i++) {
        if (serviceIdsArr[i] == "1") {
          serviceName += "无忧退货 ·";
        } else if (serviceIdsArr[i] == "2") {
          serviceName += "快速退款 ·";
        } else if (serviceIdsArr[i] == "3") {
          serviceName += "免费包邮 ·";
        }
      }
    }
    return serviceName
  }

  // 商品参数及规格盒子样式
  @Styles
  RowStyles(){
    .padding({
      top: 8,
      bottom: 8,
      left: 10,
      right: 10
    })
    .borderWidth({ bottom: 1 })
    .borderColor($r("app.color.divider"))
    .backgroundColor($r("app.color.white"))
  }


  // 商品信息
  @Builder
  buildProductInfo() {
    Column() {
      // 商品名称
      Text(this.item?.product?.name)
        .lineHeight(22)

      // 商品描述
      Text(this.item?.product?.subTitle)
        .fontSize(14)
        .fontColor($r("app.color.text_normal_2"))
        .lineHeight(20)

      // 商品价格
      Text() {
        Span("￥")
          .fontSize(12)
          .fontColor($r("app.color.btn_color_2"))
        Span(this.itemSkuStock?.price + " ")
          .fontColor($r("app.color.btn_color_2"))
        Span("￥" + this.itemSkuStock?.price)
          .fontSize(12)
          .fontColor($r("app.color.text_normal_2"))
          .decoration({
            type: TextDecorationType.LineThrough,
            color: $r("app.color.text_normal_2")
          })
      }
      .width("100%")
      .lineHeight(25)

      // 商品数据
      Row() {
        // 销量
        Text() {
          Span("销量:")
          Span(this.item?.product?.sale?.toString())
        }
        .width("33%")
        .fontSize(12)
        .fontColor($r("app.color.text_normal_2"))

        // 库存
        Text() {
          Span("库存:")
          Span(this.itemSkuStock?.stock?.toString())
        }
        .width("33%")
        .fontSize(12)
        .fontColor($r("app.color.text_normal_2"))

        // 浏览量
        Text() {
          Span("浏览量:")
          Span("768")
        }
        .width("33%")
        .fontSize(12)
        .fontColor($r("app.color.text_normal_2"))
      }
      .width("100%")
      .height(26)
    }
    .padding(10)
    .backgroundColor($r("app.color.white"))
  }

  // 底部悬浮菜单
  @Builder
  buildBottomMenu() {
    Row() {
      // 首页按钮
      Column() {
        Image($r("app.media.tab_home"))
          .width(20)
        Text('首页')
          .fontSize(14)
          .fontColor($r("app.color.text_normal_3"))
      }
      .onClick(() => {
        router.replaceUrl({ url: "pages/Index" })
      })

      // 购物车按钮
      Column() {
        Image($r("app.media.tab_cart"))
          .width(20)
        Text("购物车")
          .fontSize(14)
          .fontColor($r("app.color.text_normal_3"))
      }
      .onClick(() => {
        router.replaceUrl({ url: "pages/Index", params: { currentIndex: 2 } as routerParams })
      })

      // 收藏按钮
      Column() {
        Image($r("app.media.icon_like_svg"))
          .width(20)
          .fillColor("#909399")
        Text("收藏")
          .fontSize(14)
          .fontColor($r("app.color.text_normal_3"))
      }
      .onClick(() => {
        promptAction.showToast({
          alignment: Alignment.Center,
          message: "未实现！"
        })
      })

      Row() {
        // 购买按钮
        Text("立即购买")
          .fontSize(14)
          .fontColor($r("app.color.white"))
          .padding({
            left: 10,
            right: 10,
            top: 8,
            bottom: 8
          })
          .onClick((event) => {
            promptAction.showToast({
              alignment: Alignment.Center,
              message: "暂时只支持在购物车下单！"
            })
          })
        Row().width(1).height(16).backgroundColor($r("app.color.text_normal_2"))

        // 加入购物车按钮
        Text("加入购物车")
          .fontSize(14)
          .fontColor($r("app.color.white"))
          .padding({
            left: 6,
            right: 10,
            top: 8,
            bottom: 8
          })
          .onClick((event) => {
            let obj: addCartReqParams = {
              price: this.item?.product?.price,
              productAttr: JSON.stringify(this.itemProperty),
              productBrand: this.item?.brand?.name,
              productCategoryId: this.item?.product?.productCategoryId,
              productId: this.item?.product?.id,
              productName: this.item?.product?.name,
              productPic: this.item?.product?.pic,
              productSkuCode: this.itemSkuStock?.skuCode,
              productSkuId: this.itemSkuStock?.id,
              productSn: this.item?.product?.productSn,
              productSubTitle: this.item?.product?.subTitle,
              quantity: 1
            }
            addCartItem(obj).then(() => {
              promptAction.showToast({
                alignment: Alignment.Center,
                message: "操作成功！"
              })
            })
          })
      }
      .borderRadius("50%")
      // 渐变色背景
      .linearGradient({
        direction: GradientDirection.Right, // 渐变方向
        colors: [["#FFA832", 0.0], ["#FA4E70", 0.5], ["#F56B6B", 1]] // 数组末尾元素占比小于1时满足重复着色效果
      })
    }
    .width("90%")
    .borderRadius(8)
    .padding({ top: 8, bottom: 8 })
    .backgroundColor($r("app.color.white_08t"))
    .justifyContent(FlexAlign.SpaceEvenly)
    .shadow({
      radius: 20,
      color: $r('app.color.text_normal_3')
    })
  }
}
// 标题样式
@Extend(Text)
function textTitStyles() {
  .width("20%")
  .fontSize(14)
  .fontColor($r("app.color.text_normal_3"))
}

// 子标题样式
@Extend(Text)
function textSubTitStyles() {
  .layoutWeight(1)
  .fontSize(14)
  .fontColor($r("app.color.text_normal_4"))
}