package com.springboot.myapp.eds.erp.controller.order;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.order.orderPlanListVO;


@Repository
public interface orderPlanMapper {

    public List<orderPlanListVO> selectOrderPlanList(Map<String, Object> map) throws Exception;
    public List<orderPlanListVO> selectOrderPlanListForList(Map<String, Object> map) throws Exception;
    public List<orderPlanListVO> selectOrderPlanDiviItem(Map<String, Object> map) throws Exception;
    public List<orderPlanListVO> selectOrderPlanSetList(Map<String, Object> map) throws Exception;

    public int insertOrderPlanList(Map<String, Object> map) throws Exception;
    public int cuOrderPlanSetList(Map<String, Object> map) throws Exception;

    public int updateOrderPlanList(Map<String, Object> map) throws Exception;

    public int deleteOrderPlanList(Map<String, Object> map) throws Exception;
}
