// 收货地址
interface Address {
  // 城市
  city?: string;

  // 是否为默认
  defaultStatus?: number;

  // 提交默认状态
  default?:boolean;

  // 详细地址(街道)
  detailAddress?: string;

  // id
  id?: number;

  // 会员id
  memberId?: number;

  // 收货人名称
  name?: string;

  // 手机号
  phoneNumber?: string;

  // 邮政编码
  postCode?: string;

  // 省份/直辖市
  province?: string;

  // 区
  region?: string;
}

class AddressModel implements Address {
  city?: string
  defaultStatus?: number
  default?:boolean;
  detailAddress?: string
  id?: number
  memberId?: number
  name?: string
  phoneNumber?: string
  postCode?: string
  province?: string
  region?: string

  constructor(model: Address) {
    this.city = model.city;
    this.defaultStatus = model.defaultStatus;
    this.default = model.default;
    this.detailAddress = model.detailAddress;
    this.id = model.id;
    this.memberId = model.memberId;
    this.name = model.name;
    this.phoneNumber = model.phoneNumber;
    this.postCode = model.postCode;
    this.province = model.province;
    this.region = model.region;
  }
}
export {Address, AddressModel}