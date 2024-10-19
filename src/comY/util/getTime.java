package comY.util;

import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class getTime {
    public static Timestamp getNowTime() {
        ZonedDateTime currentDateTime = ZonedDateTime.now();
        ZoneId zoneId = ZoneId.of("Asia/Shanghai");
        ZonedDateTime currentDateTimeInZone = currentDateTime.withZoneSameInstant(zoneId);

        // 创建日期时间格式化器
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // 格式化日期时间
        String formattedDateTime = currentDateTimeInZone.format(formatter);

        // 将格式化后的日期时间转换为Timestamp

        return Timestamp.valueOf(formattedDateTime);
    }
}
