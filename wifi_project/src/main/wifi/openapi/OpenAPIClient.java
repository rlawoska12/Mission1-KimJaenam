package main.wifi.openapi;

import com.google.gson.Gson;
import main.wifi.entity.WifiEntity;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class OpenAPIClient {

    private final String BASE_API_URL = "http://openapi.seoul.go.kr:8088";
    private final String API_KEY = "41454d54416b6a6e33315a52516779";
    private final OkHttpClient handle;

    public OpenAPIClient() {
        handle = new OkHttpClient();
    }

    public List<WifiEntity> getWifiList(int startIdx, int endIdx) throws IOException {
        List<String> apiUrlBuilder = new ArrayList<>();
        apiUrlBuilder.add(BASE_API_URL);
        apiUrlBuilder.add(API_KEY);
        apiUrlBuilder.add("json");
        apiUrlBuilder.add("TbPublicWifiInfo");
        apiUrlBuilder.add(String.valueOf(startIdx));
        apiUrlBuilder.add(String.valueOf(endIdx));
        String apiUrl = String.join("/", apiUrlBuilder);

        Request request = new Request.Builder().url(apiUrl).get().build();
        Response response = handle.newCall(request).execute();
        if (response.body() == null) {
            return new ArrayList<>();
        }

        Gson gson = new Gson();
        OpenAPIResponse.PublicWifiInfo publicWifiInfo = gson.fromJson(response.body().string(), OpenAPIResponse.PublicWifiInfo.class);

        if (!publicWifiInfo.entity.result.isSuccess()) {
            return new ArrayList<>();
        }

        return publicWifiInfo.entity.row.stream()
                .map(OpenAPIResponse.WifiInfoItem::toEntity).collect(Collectors.toList());
    }

    public List<WifiEntity> getAllWifiList() throws IOException {
        List<WifiEntity> allWifiList = new ArrayList<>();
        int limit = 1000;
        int startIdx = 1;
        int endIdx = limit;
        while (true) {
            List<WifiEntity> res = getWifiList(startIdx, endIdx);
            allWifiList.addAll(res);
            if (res.size() < limit) {
                break;
            }
            startIdx += limit;
            endIdx += limit;
        }
        return allWifiList;
    }

}
