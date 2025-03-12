

// 属性
export interface property {
  key: string, // key
  value: string // value
}
// {key:"尺寸",value:"XL"}


// 属性数组
export interface propertyArr {
  key: string, // key
  value: string[] // value
}
// {key:"颜色",value:["黑色","白色"]}

export interface addCartReqParams {
  price?: number, // 价格
  productAttr?: string, // 属性
  productBrand?: string, // 品牌
  productCategoryId?: number, // 分类id
  productId?: number, // 商品id
  productName?: string, // 商品名称
  productPic?: string, // 图片
  productSkuCode?: string, // sku编码
  productSkuId?: number, // skuId
  productSn?: string, // 商品编号
  productSubTitle?: string, // 子标题
  quantity?: number // 数量
}

/**
 * CommonPage«PmsProduct»
 */
export interface CommonPagePmsProduct {
  list?: PmsProduct[];
  pageNum?: number;
  pageSize?: number;
  total?: number;
  totalPage?: number;
}

/**
 * PmsProduct
 */
export interface PmsProduct {
  /**
   * 画册图片，连产品图片限制为5张，以逗号分割
   */
  albumPics?: string;
  brandId?: number;
  /**
   * 品牌名称
   */
  brandName?: string;
  /**
   * 删除状态：0->未删除；1->已删除
   */
  deleteStatus?: number;
  /**
   * 商品描述
   */
  description?: string;
  detailDesc?: string;
  /**
   * 产品详情网页内容
   */
  detailHtml?: string;
  /**
   * 移动端网页详情
   */
  detailMobileHtml?: string;
  detailTitle?: string;
  feightTemplateId?: number;
  /**
   * 赠送的成长值
   */
  giftGrowth?: number;
  /**
   * 赠送的积分
   */
  giftPoint?: number;
  id?: number;
  keywords?: string;
  /**
   * 库存预警值
   */
  lowStock?: number;
  name?: string;
  /**
   * 新品状态:0->不是新品；1->新品
   */
  newStatus?: number;
  note?: string;
  /**
   * 市场价
   */
  originalPrice?: number;
  pic?: string;
  /**
   * 是否为预告商品：0->不是；1->是
   */
  previewStatus?: number;
  price?: number;
  productAttributeCategoryId?: number;
  productCategoryId?: number;
  /**
   * 商品分类名称
   */
  productCategoryName?: string;
  /**
   * 货号
   */
  productSn?: string;
  /**
   * 促销结束时间
   */
  promotionEndTime?: Date;
  /**
   * 活动限购数量
   */
  promotionPerLimit?: number;
  /**
   * 促销价格
   */
  promotionPrice?: number;
  /**
   * 促销开始时间
   */
  promotionStartTime?: Date;
  /**
   * 促销类型：0->没有促销使用原价;1->使用促销价；2->使用会员价；3->使用阶梯价格；4->使用满减价格；5->限时购
   */
  promotionType?: number;
  /**
   * 上架状态：0->下架；1->上架
   */
  publishStatus?: number;
  /**
   * 推荐状态；0->不推荐；1->推荐
   */
  recommandStatus?: number;
  /**
   * 销量
   */
  sale?: number;
  /**
   * 以逗号分割的产品服务：1->无忧退货；2->快速退款；3->免费包邮
   */
  serviceIds?: string;
  /**
   * 排序
   */
  sort?: number;
  /**
   * 库存
   */
  stock?: number;
  /**
   * 副标题
   */
  subTitle?: string;
  /**
   * 单位
   */
  unit?: string;
  /**
   * 限制使用的积分数
   */
  usePointLimit?: number;
  /**
   * 审核状态：0->未审核；1->审核通过
   */
  verifyStatus?: number;
  /**
   * 商品重量，默认为克
   */
  weight?: number;
}
/**
 * PmsPortalProductDetail
 */
export interface PmsPortalProductDetail {
  brand?: PmsBrand;
  /**
   * 商品可用优惠券
   */
  couponList?: SmsCoupon1[];
  product?: PmsProduct;
  /**
   * 商品属性与参数
   */
  productAttributeList?: PmsProductAttribute[];
  /**
   * 手动录入的商品属性与参数值
   */
  productAttributeValueList?: PmsProductAttributeValue[];
  /**
   * 商品满减价格设置
   */
  productFullReductionList?: PmsProductFullReduction[];
  /**
   * 商品阶梯价格设置
   */
  productLadderList?: PmsProductLadder[];
  /**
   * 商品的sku库存信息
   */
  skuStockList?: PmsSkuStock[];

}

/**
 * PmsBrand
 */
export interface PmsBrand {
  /**
   * 专区大图
   */
  bigPic?: string;
  /**
   * 品牌故事
   */
  brandStory?: string;
  /**
   * 是否为品牌制造商：0->不是；1->是
   */
  factoryStatus?: number;
  /**
   * 首字母
   */
  firstLetter?: string;
  id?: number;
  /**
   * 品牌logo
   */
  logo?: string;
  name?: string;
  /**
   * 产品评论数量
   */
  productCommentCount?: number;
  /**
   * 产品数量
   */
  productCount?: number;
  showStatus?: number;
  sort?: number;
}

/**
 * SmsCoupon
 */
export interface SmsCoupon1 {
  /**
   * 金额
   */
  amount?: number;
  /**
   * 优惠码
   */
  code?: string;
  /**
   * 数量
   */
  count?: number;
  /**
   * 可以领取的日期
   */
  enableTime?: Date;
  endTime?: Date;
  id?: number;
  /**
   * 可领取的会员类型：0->无限时
   */
  memberLevel?: number;
  /**
   * 使用门槛；0表示无门槛
   */
  minPoint?: number;
  name?: string;
  /**
   * 备注
   */
  note?: string;
  /**
   * 每人限领张数
   */
  perLimit?: number;
  /**
   * 使用平台：0->全部；1->移动；2->PC
   */
  platform?: number;
  /**
   * 发行数量
   */
  publishCount?: number;
  /**
   * 领取数量
   */
  receiveCount?: number;
  startTime?: Date;
  /**
   * 优惠券类型；0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券
   */
  type?: number;
  /**
   * 已使用数量
   */
  useCount?: number;
  /**
   * 使用类型：0->全场通用；1->指定分类；2->指定商品
   */
  useType?: number;
}


/**
 * PmsProductAttribute
 */
export interface PmsProductAttribute {
  /**
   * 分类筛选样式：1->普通；1->颜色
   */
  filterType?: number;
  /**
   * 是否支持手动新增；0->不支持；1->支持
   */
  handAddStatus?: number;
  id?: number;
  /**
   * 可选值列表，以逗号隔开
   */
  inputList?: string;
  /**
   * 属性录入方式：0->手工录入；1->从列表中选取
   */
  inputType?: number;
  name?: string;
  productAttributeCategoryId?: number;
  /**
   * 相同属性产品是否关联；0->不关联；1->关联
   */
  relatedStatus?: number;
  /**
   * 检索类型；0->不需要进行检索；1->关键字检索；2->范围检索
   */
  searchType?: number;
  /**
   * 属性选择类型：0->唯一；1->单选；2->多选
   */
  selectType?: number;
  /**
   * 排序字段：最高的可以单独上传图片
   */
  sort?: number;
  /**
   * 属性的类型；0->规格；1->参数
   */
  type?: number;
}

/**
 * PmsProductAttributeValue
 */
export interface PmsProductAttributeValue {
  id?: number;
  productAttributeId?: number;
  productId?: number;
  /**
   * 手动添加规格或参数的值，参数单值，规格有多个时以逗号隔开
   */
  value?: string;
}

/**
 * PmsProductFullReduction
 */
export interface PmsProductFullReduction {
  fullPrice?: number;
  id?: number;
  productId?: number;
  reducePrice?: number;
}

/**
 * PmsProductLadder
 */
export interface PmsProductLadder {
  /**
   * 满足的商品数量
   */
  count?: number;
  /**
   * 折扣
   */
  discount?: number;
  id?: number;
  /**
   * 折后价格
   */
  price?: number;
  productId?: number;
}

/**
 * PmsSkuStock
 */
export interface PmsSkuStock {
  id?: number;
  /**
   * 锁定库存
   */
  lockStock?: number;
  /**
   * 预警库存
   */
  lowStock?: number;
  /**
   * 展示图片
   */
  pic?: string;
  price?: number;
  productId?: number;
  /**
   * 单品促销价格
   */
  promotionPrice?: number;
  /**
   * 销量
   */
  sale?: number;
  /**
   * sku编码
   */
  skuCode?: string;
  /**
   * 商品销售属性，json格式
   */
  spData?: string;
  /**
   * 库存
   */
  stock?: number;
}
