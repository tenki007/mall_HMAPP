export interface orderTabClass {
  title: string // 标题
  name?: string // 名称 或 子标题
  icon?: ResourceStr // 图标
  currentIcon?: ResourceStr // 当前图标
  onRightClick?: () => void // 点击事件
}

export enum orderTabEnum {
  ALL = 0, // 全部
  WAIT_PAY = 1, // 待付款
  WAIT_RECEIVE = 2, // 待收货
  DONE = 3, // 已完成
  CANCEL = 4 // 已取消
}