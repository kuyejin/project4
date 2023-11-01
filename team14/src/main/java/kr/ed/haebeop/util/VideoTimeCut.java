package kr.ed.haebeop.util;

import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.probe.FFmpegFormat;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.IOException;

public class VideoTimeCut {

    public static String media_player_time(String path, String sevpath, String video) {

        System.out.println("@@ media_player_time start @@");
        String returnData = "0";

        System.out.println(path);
        System.out.println(video);

        try {
            FFprobe ffprobe = new FFprobe(sevpath+"resources/ffmpeg/bin/ffprobe.exe"); // window에 설치된  ffprobe.exe 경로
            FFmpegProbeResult probeResult = ffprobe.probe(path + "/resources/upload/" + video); // 동영상 경로
            FFmpegFormat format = probeResult.getFormat();
            double second = format.duration; // 초단위

            returnData = String.format("%.0f", second);
            System.out.println("second==" + String.format("%.0f", second));

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            System.out.println("@@ media_player_time end @@");
        }
        return returnData;
    }

    public static void main(String[] args) throws IOException {
        media_player_time("D:/team_pro4/team14/src/main/webapp/", "D:/team_pro4/team14/src/main/webapp/resources/upload/","fed93bf3-9930-4653-b9fc-57de4166f961.mp4");
    }
}
