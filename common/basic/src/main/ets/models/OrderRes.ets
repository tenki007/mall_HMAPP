import { Address, CartItem } from ".";

/**
 * 生成确认订单结果
 */
export interface OrderResult {
  calcAmount?: CalcAmount; // 计算金额
  cartPromotionItemList?: CartItem[]; // 购物车信息
  couponHistoryDetailList?: SmsCouponHistoryDetail[]; // 优惠券详情
  integrationConsumeSetting?: UmsIntegrationConsumeSetting; // 积分消费设置
  memberIntegration?: number; // 会员持有的积分
  memberReceiveAddressList?: Address[]; // 收货地址
}

/**
 * 计算量
 */
export interface CalcAmount {
  freightAmount?: number; // 运费
  payAmount?: number; // 应付金额
  promotionAmount?: number; // 活动优惠
  totalAmount?: number; // 订单商品总金额
}

/**
 * SMS 优惠券历史详情
 */
export interface SmsCouponHistoryDetail {
  categoryRelationList?: SmsCouponProductCategoryRelation[]; // 优惠券关联商品分类
  coupon?: SmsCoupon; // 优惠券信息
  couponCode?: string; // 优惠券码
  couponId?: number; // 优惠券id
  createTime?: Date; // 创建时间
  getType?: number; // 获取类型：0->后台赠送；1->主动获取
  id?: number; // 优惠券领取记录id
  memberId?: number; // 会员id
  memberNickname?: string; // 领取人昵称
  orderId?: number; // 订单id
  orderSn?: string; // 订单号码
  productRelationList?: SmsCouponProductRelation[]; // 优惠券关联商品
  useStatus?: number; // 使用状态：0->未使用；1->已使用；2->已过期
  useTime?: Date; // 使用时间
}

/**
 * SMS 优惠券产品类别关系
 */
export interface SmsCouponProductCategoryRelation {
  couponId?: number; // 优惠券id
  id?: number; // id
  parentCategoryName?: string; // 父分类名称
  productCategoryId?: number; // 产品分类id
  productCategoryName?: string; // 产品分类名称
}

/**
 * 短信优惠券
 */
export interface SmsCoupon {
  amount?: number; // 优惠券面额
  code?: string; // 优惠码
  count?: number; // 数量
  enableTime?: Date; // 可以领取的日期
  endTime?: Date; // 优惠券失效时间
  id?: number; // id
  memberLevel?: number; // 可领取的会员等级[0->不限等级]
  minPoint?: number; // 使用门槛 0表示无门槛
  name?: string; // 优惠券名称
  note?: string; // 备注
  perLimit?: number; // 每人限领数量
  platform?: number; // 使用平台：0->全部；1->移动；2->PC
  publishCount?: number; // 发布数量
  receiveCount?: number; // 领取数量
  startTime?: Date; // 发布时间
  type?: number; // 优惠券类型；0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券
  useCount?: number; // 已使用数量
  useType?: number; // 使用类型 0->全场通用；1->指定分类；2->指定商品

}

/**
 * SMS 优惠券产品关系
 */
export interface SmsCouponProductRelation {
  couponId?: number; // 优惠券id
  id?: number; // id
  productId?: number; // 商品id
  productName?: string; // 商品名称
  productSn?: string; // 商品编码

}

/**
 * UMS 集成使用设置
 */
export interface UmsIntegrationConsumeSetting {
  couponStatus?: number; // 是否可以和优惠券同用；0->不可以；1->可以
  deductionPerAmount?: number; // 每一元需要抵扣的积分数量
  id?: number; // id
  maxPercentPerOrder?: number; // 每笔订单最高抵用百分比
  useUnit?: number; // 每次使用积分最小单位100

}