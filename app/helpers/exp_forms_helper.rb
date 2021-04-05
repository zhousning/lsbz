module ExpFormsHelper

  def options_for_region
    [
      [Setting.roles.lssw, Setting.roles.lssw],
      [Setting.roles.zcsw, Setting.roles.zcsw],
      [Setting.roles.wssw, Setting.roles.wssw],
      [Setting.roles.jxsw, Setting.roles.jxsw],
      [Setting.roles.yzsw, Setting.roles.yzsw]
    ]
  end                                            

  def options_for_prj_attr
    
    [
      ["正式", "正式"],
      ["临时", "临时"]
    ]
  end                                            

  def options_for_prj_type
    [
      ["单表", "单表"],
      ["园区", "园区"],
      ["迁表、合表、分表、改表", "迁表、合表、分表、改表"]
    ]
  end                                            
  def options_for_cmp_type
    [
      ["中型", "中型"],
      ["小型", "小型"],
      ["微型", "微型"],
      ["民营", "民营"],
      ["国有及国有控股", "国有及国有控股"],
      ["招商引资", "招商引资"],
      ["外资(中外合资)", "外资(中外合资)"],
      ["外资(其他)", "外资(其他)"],
      ["其他", "其他"]
    ]
  end                                            
  def options_for_vat
    [
      ["普通", "普通"],
      ["专用", "专用"]
    ]
  end                                            
end  
