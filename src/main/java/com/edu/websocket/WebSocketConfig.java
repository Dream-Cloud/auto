package com.edu.websocket;

import com.edu.interceptors.WebSocketInterceptor;
import com.edu.service.impl.WebSocketServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        //注册webSocketServer实现类,"/webSocketServer"访问webSocket的地址
        registry.addHandler(myHandler(), "/webSocketServer")
                .addInterceptors(new WebSocketInterceptor())
                .setAllowedOrigins("*");
        //使用socketjs的注册方法
        registry.addHandler(myHandler(),
                "/sockjs/webSocketServer").
                addInterceptors(new WebSocketInterceptor())
                .withSockJS();
    }

    /**
     *
     * @return 消息发送的Bean
     */
    @Bean
    public WebSocketHandler myHandler() {
        return new WebSocketServiceImpl();
    }

}
