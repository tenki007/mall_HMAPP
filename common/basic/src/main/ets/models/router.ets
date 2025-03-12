import { Address } from "."

export interface routerParams {
  id?: number // id
  currentIndex?: number // 当前激活项
  name?:string // 名称
  ids?:number[] // id列表
  address?:Address // 收货地址
}

export class routerParamsModel implements routerParams {
  id?: number;
  currentIndex?: number;
  name?: string;

  constructor(model: routerParams) {
    this.id = model.id;
    this.currentIndex = model.currentIndex;
    this.name = model.name;
  }
}