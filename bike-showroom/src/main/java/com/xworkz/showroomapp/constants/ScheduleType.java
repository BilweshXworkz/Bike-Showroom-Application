package com.xworkz.showroomapp.constants;

public enum ScheduleType {
    SCHEDULE_TEST_RIDE(0),
    BOOKING(1);

    private final int code;

    ScheduleType(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static ScheduleType fromCode(int code) {
        for (ScheduleType type : ScheduleType.values()) {
            if (type.getCode() == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid code: " + code);
    }

    public static String getNameByCode(int code) {
        for (ScheduleType type : ScheduleType.values()) {
            if (type.getCode() == code) {
                return type.name().replace("_", " ").toLowerCase();
            }
        }
        return "Unknown";
    }
}
