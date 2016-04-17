package com.example.apchanda.asynctask;

import java.util.Date;

/**
 * Created by apchanda on 11/19/2015.
 */
public class WeatherInfo {

    private double minTemp;
    private double maxTemp;
    private Date date;
    private String forecast;

    public double getMinTemp() {
        return minTemp;
    }

    public void setMinTemp(double minTemp) {
        this.minTemp = minTemp;
    }

    public double getMaxTemp() {
        return maxTemp;
    }

    public void setMaxTemp(double maxTemp) {
        this.maxTemp = maxTemp;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getForecast() {
        return forecast;
    }

    public void setForecast(String forecast) {
        this.forecast = forecast;
    }

    @Override
    public String toString() {
        return minTemp+" "+maxTemp+" "+date.toString()+" "+forecast;
    }
}
