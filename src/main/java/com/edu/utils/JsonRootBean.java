package com.edu.utils;

import java.util.List;





public class JsonRootBean {

    private String nwkAddr;
    private String parAddr;
    private String macAddr;
    private List<JsonBean> funcList;


    @Override
    public String toString() {
        return "macAddr"+getMacAddr()+"nwkAddr"+getNwkAddr()+"parAddr"+getParAddr();
    }

    public String getNwkAddr() {
        return nwkAddr;
    }

    public void setNwkAddr(String nwkAddr) {
        this.nwkAddr = nwkAddr;
    }

    public String getParAddr() {
        return parAddr;
    }

    public void setParAddr(String parAddr) {
        this.parAddr = parAddr;
    }

    public String getMacAddr() {
        return macAddr;
    }

    public void setMacAddr(String macAddr) {
        this.macAddr = macAddr;
    }

    public List<JsonBean> getFuncList() {
        return funcList;
    }

    public void setFuncList(List<JsonBean> funcList) {
        this.funcList = funcList;
    }


}



