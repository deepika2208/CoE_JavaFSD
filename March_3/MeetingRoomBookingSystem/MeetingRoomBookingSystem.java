package techM;
import java.util.EnumSet;
import java.util.List;

public class MeetingRoomBookingSystem {
    public static void main(String[] args) {
        RoomScheduler scheduler = new RoomScheduler();

        scheduler.addMeetingRoom(new MeetingRoom("001", "Boardroom", 20, 
                EnumSet.of(RoomFeature.PROJECTOR, RoomFeature.CONFERENCE_PHONE, RoomFeature.AIR_CONDITIONING)));
        
        scheduler.addMeetingRoom(new MeetingRoom("002", "Strategy Room", 10, 
                EnumSet.of(RoomFeature.WHITEBOARD, RoomFeature.AIR_CONDITIONING)));

        System.out.println(scheduler.bookRoom("001", EnumSet.of(RoomFeature.PROJECTOR, RoomFeature.CONFERENCE_PHONE)));

        List<MeetingRoom> availableRooms = scheduler.listAvailableRooms(EnumSet.of(RoomFeature.AIR_CONDITIONING));
        if (!availableRooms.isEmpty()) {
            System.out.print("Available rooms with AIR_CONDITIONING: [");
            for (int i = 0; i < availableRooms.size(); i++) {
                System.out.print(availableRooms.get(i).getRoomName());
                if (i < availableRooms.size() - 1) {
                    System.out.print(", ");
                }
            }
            System.out.println("]");
        } else {
            System.out.println("No available rooms with the requested features.");
        }


    }
}
