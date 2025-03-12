import { PmsBrand, PmsProduct } from ".";

/**
 * HomeContentResult
 */
export interface HomeContentResult {
  /**
   * 轮播广告
   */
  advertiseList?: SmsHomeAdvertise[];
  /**
   * 推荐品牌
   */
  brandList?: PmsBrand[];
  homeFlashPromotion?: HomeFlashPromotion;
  /**
   * 人气推荐
   */
  hotProductList?: PmsProduct[];
  /**
   * 新品推荐
   */
  newProductList?: PmsProduct[];
  /**
   * 推荐专题
   */
  subjectList?: CmsSubject[];
}

/**
 * SmsHomeAdvertise
 */
export interface SmsHomeAdvertise {
  /**
   * 点击数
   */
  clickCount?: number;
  endTime?: Date;
  id?: number;
  name?: string;
  /**
   * 备注
   */
  note?: string;
  /**
   * 下单数
   */
  orderCount?: number;
  pic?: string;
  /**
   * 排序
   */
  sort?: number;
  startTime?: Date;
  /**
   * 上下线状态：0->下线；1->上线
   */
  status?: number;
  /**
   * 轮播位置：0->PC首页轮播；1->app首页轮播
   */
  type?: number;
  /**
   * 链接地址
   */
  url?: string;
}

/**
 * HomeFlashPromotion
 */
export interface HomeFlashPromotion {
  /**
   * 本场结束时间
   */
  endTime?: Date;
  /**
   * 下场结束时间
   */
  nextEndTime?: Date;
  /**
   * 下场开始时间
   */
  nextStartTime?: Date;
  /**
   * 属于该秒杀活动的商品
   */
  productList?: FlashPromotionProduct[];
  /**
   * 本场开始时间
   */
  startTime?: Date;
}

/**
 * FlashPromotionProduct
 */
export interface FlashPromotionProduct {
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
   * 用于秒杀到数量
   */
  flashPromotionCount?: number;
  /**
   * 秒杀限购数量
   */
  flashPromotionLimit?: number;
  /**
   * 秒杀价格
   */
  flashPromotionPrice?: number;
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
 * CmsSubject
 */
export interface CmsSubject {
  /**
   * 画册图片用逗号分割
   */
  albumPics?: string;
  categoryId?: number;
  /**
   * 专题分类名称
   */
  categoryName?: string;
  collectCount?: number;
  commentCount?: number;
  content?: string;
  createTime?: Date;
  description?: string;
  /**
   * 转发数
   */
  forwardCount?: number;
  id?: number;
  /**
   * 专题主图
   */
  pic?: string;
  /**
   * 关联产品数量
   */
  productCount?: number;
  readCount?: number;
  recommendStatus?: number;
  /**
   * 显示状态：0->不显示；1->显示
   */
  showStatus?: number;
  title?: string;
}