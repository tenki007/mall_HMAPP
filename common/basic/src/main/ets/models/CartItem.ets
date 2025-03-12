/**
 * 购物车项目
 */
export interface CartItem {
  createDate?: Date; // 创建时间
  deleteStatus?: number; // 是否删除
  id?: number;
  memberId?: number;
  memberNickname?: string; // 会员昵称
  modifyDate?: Date; // 修改时间
  price?: number; // 添加到购物车的价格
  productAttr?: string; // 商品销售属性:[{'key':'颜色','value':'颜色'},{'key':'容量','value':'4G'}]
  productBrand?: string;
  productCategoryId?: number; // 商品分类
  productId?: number;
  productName?: string; // 商品名称
  productPic?: string; // 商品主图
  productSkuCode?: string; // 商品sku条码
  productSkuId?: number;
  productSn?: string;
  productSubTitle?: string; // 商品副标题（卖点）
  quantity?: number; // 购买数量
  growth?: number; // 购买商品赠送成长值
  integration?: number; // 购买商品赠送积分
  promotionMessage?: string; // 优惠券信息
  realStock?: number; // 剩余库存-锁定库存
  reduceAmount?: number; // 促销活动减去的金额，针对每个商品
}

export class CartItemModel implements CartItem {
  createDate?: Date;
  deleteStatus?: number;
  id?: number;
  memberId?: number;
  memberNickname?: string;
  modifyDate?: Date;
  price?: number;
  productAttr?: string;
  productBrand?: string;
  productCategoryId?: number;
  productId?: number;
  productName?: string;
  productPic?: string;
  productSkuCode?: string;
  productSkuId?: number;
  productSn?: string;
  productSubTitle?: string;
  quantity?: number;
  growth?: number;
  integration?: number;
  promotionMessage?: string;
  realStock?: number;
  reduceAmount?: number;


  constructor(model: CartItem) {
    this.createDate = model.createDate;
    this.deleteStatus = model.deleteStatus;
    this.id = model.id;
    this.memberId = model.memberId;
    this.memberNickname = model.memberNickname;
    this.modifyDate = model.modifyDate;
    this.price = model.price;
    this.productAttr = model.productAttr;
    this.productBrand = model.productBrand;
    this.productCategoryId = model.productCategoryId;
    this.productId = model.productId;
    this.productName = model.productName;
    this.productPic = model.productPic;
    this.productSkuCode = model.productSkuCode;
    this.productSkuId = model.productSkuId;
    this.productSn = model.productSn;
    this.productSubTitle = model.productSubTitle;
    this.quantity = model.quantity;
    this.growth = model.growth;
    this.integration = model.integration;
    this.promotionMessage = model.promotionMessage;
    this.realStock = model.realStock;
    this.reduceAmount = model.reduceAmount;
  }

}