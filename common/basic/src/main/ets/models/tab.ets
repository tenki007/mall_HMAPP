export interface TabClass {
  title: string
  name?: string
  icon?: ResourceStr
  currenticon?:ResourceStr
  onRightClick?: () => void
}
export interface CardItemClass{
  onRightClick?: () => void
  leftTitle: string
  showBottomBorder?: boolean
  showRightIcon?: boolean
  leftIcon?:ResourceStr
  rightText?: string
}