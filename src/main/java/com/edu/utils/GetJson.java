package com.edu.utils;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.util.ArrayList;

public class GetJson {
    private String uri = "http://192.168.0.1/cgi-bin/node.cgi";

    private JsonBean light;
    private JsonBean tem;
    private JsonBean hum;
    private JsonBean control;

    public GetJson() {
        ArrayList<JsonRootBean> jsonRootBeans = getBean(getAll());
        for (JsonRootBean jsonRootBean:jsonRootBeans){
            switch (jsonRootBean.getMacAddr()){
                case "E0DE5305004B1200":
                    light = jsonRootBean.getFuncList().get(0);
                    break;
                case "9C625305004B1200":
                    JsonBean jsonBean = jsonRootBean.getFuncList().get(0);
                    if (jsonBean.getTypeCode()==1){
                        tem = jsonBean;
                        hum = jsonRootBean.getFuncList().get(1);
                    }else {
                        tem = jsonRootBean.getFuncList().get(1);
                        hum = jsonBean;
                    }

                    break;
                case "0BE05305004B1200":
                    control = jsonRootBean.getFuncList().get(0);
                    break;
            }
        }
    }

    public JsonBean getLight() {
        return light;
    }

    public JsonBean getTem() {
        return tem;
    }
    public JsonBean getHum() {
        return hum;
    }

    public JsonBean getControl() {
        return control;
    }


    public ArrayList<JsonRootBean> getBean(String json){
        //Json的解析类对象
        JsonParser parser = new JsonParser();
        //将JSON的String 转成一个JsonArray对象
        JsonArray jsonArray = parser.parse(json).getAsJsonArray();

        Gson gson = new Gson();
        ArrayList<JsonRootBean> userBeanList = new ArrayList<>();

        //加强for循环遍历JsonArray
        for (JsonElement user : jsonArray) {
            //使用GSON，直接转成Bean对象
            JsonRootBean userBean = gson.fromJson(user, JsonRootBean.class);
            userBeanList.add(userBean);
        }
        return userBeanList;
    }

    public String getAll(){
        String result = "";
        try {
            CloseableHttpClient client = null;
            CloseableHttpResponse response = null;
            try {
                HttpGet httpGet = new HttpGet(uri);
                client = HttpClients.createDefault();
                response = client.execute(httpGet);
                HttpEntity entity = response.getEntity();
                result = EntityUtils.toString(entity);
            } finally {
                if (response != null) {
                    response.close();
                }
                if (client != null) {
                    client.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
