import com.impinj.octane.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * Created by Xingyu on 2021/5/13.
 * Generate settings.
 */

public class ReaderSettings {
    public static void main(String[] args) {
        // Input the hostname or IP address of the reader in command line or specify its hostname in the code
        System.out.println("Input the  hostname of the reader");
        Scanner scanner = new Scanner(System.in);
        String hostname = scanner.nextLine();    // IP address of the reader
        ImpinjReader reader = new ImpinjReader();
        try {
            reader.connect(hostname+".local");
        } catch (OctaneSdkException e) {
            e.printStackTrace();
        }
        Settings settings = reader.queryDefaultSettings();
        settings.setReaderMode(ReaderMode.MaxThroughput);
        // In this work, we use the persistence time of session 1 as the metric to do temperature sensing
        // The corresponding settings are given below
        settings.setSearchMode(SearchMode.SingleTarget); // Query A
        settings.setSession(1); // Session 1
        settings.setTagPopulationEstimate(1);
        ArrayList<AntennaConfig> arrayList = settings.getAntennas().getAntennaConfigs();
        for (AntennaConfig ac : arrayList) {
            ac.setEnabled(false);
            ac.setIsMaxTxPower(false);
            ac.setTxPowerinDbm(31.5);
            ac.setIsMaxRxSensitivity(true);
        }
        AntennaConfig ac = arrayList.get(0);
        ac.setEnabled(true);
        ReportConfig r = settings.getReport();
        r.setIncludeAntennaPortNumber(true);
        r.setIncludeFirstSeenTime(true);
        r.setIncludeLastSeenTime(true);
        r.setIncludeFastId(true);
        r.setIncludePeakRssi(true);
        r.setIncludePcBits(true);
        r.setIncludeChannel(true);
        r.setIncludeDopplerFrequency(true);
        r.setIncludePhaseAngle(true);
        r.setMode(ReportMode.Individual);
        settings.setReport(r);
        // Select a subset of tags in the environment.
        TagFilter t1 = settings.getFilters().getTagFilter1();
        t1.setBitCount(32);
        t1.setBitPointer(32);
        t1.setMemoryBank(MemoryBank.Epc);
        t1.setFilterOp(TagFilterOp.Match);
        // If the first 32 bits of a tag's ID follows the mask "ox20210414", it will reply to the reader.
        // The mask should be the same as the ID of the tag used in temperature sensing.
        t1.setTagMask("20210414");
        settings.getFilters().setMode(TagFilterMode.OnlyFilter1);
        try {
            settings.save("ReadTags/settings.json");
        } catch (IOException e) {
            e.printStackTrace();
        }
        reader.disconnect();
    }
}
