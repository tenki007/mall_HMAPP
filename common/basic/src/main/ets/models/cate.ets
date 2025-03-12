export interface PmsProductCategoryNode {
  /**
   * 子分类集合
   */
  children?: PmsProductCategoryNode[];
  /**
   * 描述
   */
  description?: string;
  /**
   * 图标
   */
  icon?: string;
  id?: number;
  keywords?: string;
  /**
   * 分类级别：0->1级；1->2级
   */
  level?: number;
  name?: string;
  /**
   * 是否显示在导航栏：0->不显示；1->显示
   */
  navStatus?: number;
  /**
   * 上机分类的编号：0表示一级分类
   */
  parentId?: number;
  productCount?: number;
  productUnit?: string;
  /**
   * 显示状态：0->不显示；1->显示
   */
  showStatus?: number;
  sort?: number;
}
