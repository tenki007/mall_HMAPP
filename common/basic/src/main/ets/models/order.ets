
export interface kv{
  key:string
  value:string
}


export interface OrderRequest {
  /**
   * pageNum
   */
  pageNum?: number;
  /**
   * pageSize
   */
  pageSize?: number;
  /**
   * 订单状态：-1->全部；0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭
   */
  status: number;
}

/**
 * CommonResult«CommonPage«OmsOrderDetail»»
 */
export interface Response {
  code?: number;
  data?: CommonPageOmsOrderDetail;
  message?: string;
}

/**
 * CommonPage«OmsOrderDetail»
 */
export interface CommonPageOmsOrderDetail {
  list?: OrderDetail[];
  pageNum?: number;
  pageSize?: number;
  total?: number;
  totalPage?: number;
}

/**
 * OmsOrderDetail
 */
export interface OrderDetail {
  /**
   * 自动确认时间（天）
   */
  autoConfirmDay?: number;
  /**
   * 发票内容
   */
  billContent?: string;
  /**
   * 发票抬头
   */
  billHeader?: string;
  /**
   * 收票人邮箱
   */
  billReceiverEmail?: string;
  /**
   * 收票人电话
   */
  billReceiverPhone?: string;
  /**
   * 发票类型：0->不开发票；1->电子发票；2->纸质发票
   */
  billType?: number;
  /**
   * 评价时间
   */
  commentTime?: Date;
  /**
   * 确认收货状态：0->未确认；1->已确认
   */
  confirmStatus?: number;
  /**
   * 优惠券抵扣金额
   */
  couponAmount?: number;
  couponId?: number;
  /**
   * 提交时间
   */
  createTime?: Date;
  /**
   * 删除状态：0->未删除；1->已删除
   */
  deleteStatus?: number;
  /**
   * 物流公司(配送方式)
   */
  deliveryCompany?: string;
  /**
   * 物流单号
   */
  deliverySn?: string;
  /**
   * 发货时间
   */
  deliveryTime?: Date;
  /**
   * 管理员后台调整订单使用的折扣金额
   */
  discountAmount?: number;
  /**
   * 运费金额
   */
  freightAmount?: number;
  /**
   * 可以活动的成长值
   */
  growth?: number;
  /**
   * 订单id
   */
  id?: number;
  /**
   * 可以获得的积分
   */
  integration?: number;
  /**
   * 积分抵扣金额
   */
  integrationAmount?: number;
  memberId?: number;
  /**
   * 用户帐号
   */
  memberUsername?: string;
  /**
   * 修改时间
   */
  modifyTime?: Date;
  /**
   * 订单备注
   */
  note?: string;
  /**
   * 订单商品列表
   */
  orderItemList?: OmsOrderItem[];
  /**
   * 订单编号
   */
  orderSn?: string;
  /**
   * 订单类型：0->正常订单；1->秒杀订单
   */
  orderType?: number;
  /**
   * 应付金额（实际支付金额）
   */
  payAmount?: number;
  /**
   * 支付时间
   */
  paymentTime?: Date;
  /**
   * 支付方式：0->未支付；1->支付宝；2->微信
   */
  payType?: number;
  /**
   * 促销优化金额（促销价、满减、阶梯价）
   */
  promotionAmount?: number;
  /**
   * 活动信息
   */
  promotionInfo?: string;
  /**
   * 城市
   */
  receiverCity?: string;
  /**
   * 详细地址
   */
  receiverDetailAddress?: string;
  /**
   * 收货人姓名
   */
  receiverName?: string;
  /**
   * 收货人电话
   */
  receiverPhone?: string;
  /**
   * 收货人邮编
   */
  receiverPostCode?: string;
  /**
   * 省份/直辖市
   */
  receiverProvince?: string;
  /**
   * 区
   */
  receiverRegion?: string;
  /**
   * 确认收货时间
   */
  receiveTime?: Date;
  /**
   * 订单来源：0->PC订单；1->app订单
   */
  sourceType?: number;
  /**
   * 订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单
   */
  status?: number;
  /**
   * 订单总金额
   */
  totalAmount?: number;
  /**
   * 下单时使用的积分
   */
  useIntegration?: number;

}

/**
 * OmsOrderItem
 */
export interface OmsOrderItem {
  /**
   * 优惠券优惠分解金额
   */
  couponAmount?: number;
  giftGrowth?: number;
  giftIntegration?: number;
  id?: number;
  /**
   * 积分优惠分解金额
   */
  integrationAmount?: number;
  /**
   * 订单id
   */
  orderId?: number;
  /**
   * 订单编号
   */
  orderSn?: string;
  /**
   * 商品销售属性:[{'key':'颜色','value':'颜色'},{'key':'容量','value':'4G'}]
   */
  productAttr?: string;
  productBrand?: string;
  /**
   * 商品分类id
   */
  productCategoryId?: number;
  productId?: number;
  productName?: string;
  productPic?: string;
  /**
   * 销售价格
   */
  productPrice?: number;
  /**
   * 购买数量
   */
  productQuantity?: number;
  /**
   * 商品sku条码
   */
  productSkuCode?: string;
  /**
   * 商品sku编号
   */
  productSkuId?: number;
  productSn?: string;
  /**
   * 商品促销分解金额
   */
  promotionAmount?: number;
  /**
   * 商品促销名称
   */
  promotionName?: string;
  /**
   * 该商品经过优惠后的分解金额
   */
  realAmount?: number;
}
/**
 * 生成订单时参数
 */
export interface OrderParam {
  cartIds?: number[]; // 被选中的购物车商品ID
  couponId?: number; // 优惠券ID
  memberReceiveAddressId?: number; // 收货地址ID
  payType?: number; // 支付方式
  useIntegration?: number; // 使用的积分数
}


/**
 * 订单下单成功返回结果
 */

export interface OrderResponse {
  orderItemList?: OmsOrderItem[]; // 订单商品列表
  order?: OrderDetail; // 订单信息
}

// 支付方式枚举 0->未支付；1->支付宝；2->微信
export enum payTypeEnum {
  UNPAID = 0, // 未支付
  ALIPAY = 1, // 支付宝
  WECHAT = 2 // 微信
}