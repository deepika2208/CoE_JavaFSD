package techM;
import java.util.*;

public class RoomScheduler {
    private Map<String, MeetingRoom> meetingRooms;

    public RoomScheduler() {
        this.meetingRooms = new HashMap<>();
    }

    public void addMeetingRoom(MeetingRoom room) {
        meetingRooms.put(room.getRoomId(), room);
        System.out.println("Room added: " + room.getRoomName() + ", ID: " + room.getRoomId());
    }

    public String bookRoom(String roomId, EnumSet<RoomFeature> requiredFeatures) {
        MeetingRoom room = meetingRooms.get(roomId);
        if (room == null) {
            return "Room ID " + roomId + " not found.";
        }
        if (room.getFeatures().containsAll(requiredFeatures)) {
            return "Room " + roomId + " booked successfully.";
        } else {
            return "Room " + roomId + " does not meet the requirements.";
        }
    }

    public List<MeetingRoom> listAvailableRooms(EnumSet<RoomFeature> requiredFeatures) {
        List<MeetingRoom> availableRooms = new ArrayList<>();
        for (MeetingRoom room : meetingRooms.values()) {
            if (room.getFeatures().containsAll(requiredFeatures)) {
                availableRooms.add(room);
            }
        }
        return availableRooms;
    }
}
