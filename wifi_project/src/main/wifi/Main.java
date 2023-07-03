package main.wifi;

import main.wifi.openapi.OpenAPIClient;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        OpenAPIClient apiClient = new OpenAPIClient();
        apiClient.getWifiList(0, 100);
    }
}
