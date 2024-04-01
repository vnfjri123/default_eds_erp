package com.springboot.myapp.eds.ims.controller.dashboard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashboardController {

  @RequestMapping("/DASHBOARD_VIEW")
  public String dashboardView() {
    return "/eds/ims/dashboard/dashboardView";
  }

}
