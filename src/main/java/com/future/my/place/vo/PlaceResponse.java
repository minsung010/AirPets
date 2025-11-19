package com.future.my.place.vo;

import java.util.ArrayList;
import java.util.List;

import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "response")
public class PlaceResponse {

    private Body body;

    @XmlElement
    public Body getBody() { return body; }
    public void setBody(Body body) { this.body = body; }

    // Body 클래스
    public static class Body {

        private Items items;

        @XmlElement(name = "items")
        public Items getItems() { return items; }
        public void setItems(Items items) { this.items = items; }
    }

    // Items 클래스
    public static class Items {

        private List<PlaceVO> item;

        @XmlElement(name = "item")
        public List<PlaceVO> getItemList() {
            if (item == null) {
                item = new ArrayList<PlaceVO>();
            }
            return item;
        }

        public void setItemList(List<PlaceVO> item) {
            this.item = item;
        }
    }
}
