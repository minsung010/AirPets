package com.future.my.air.web;

import com.future.my.air.service.AirService2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/air")
public class AirController2 {

    @Autowired
    private AirService2 airService2;

    // JSP 화면
    @GetMapping
    public String airView() {
        return "air/airView2"; // /WEB-INF/views/air/airView2.jsp
    }

    // JSON API: 지상관측소 목록
    @GetMapping("/stations")
    @ResponseBody
    public List<Map<String, Object>> getStations() {
        return airService2.getAllStations();
    }


    // JSON API: 지점 상세 정보
    @GetMapping("/station/{stnId}")
    @ResponseBody
    public Map<String, Object> getStation(@PathVariable String stnId) {
        return airService2.getStationData(stnId);
    }
}
