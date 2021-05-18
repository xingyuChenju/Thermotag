import com.impinj.octane.ImpinjReader;
import com.impinj.octane.Tag;
import com.impinj.octane.TagReport;
import com.impinj.octane.TagReportListener;
import java.text.DecimalFormat;
import java.util.List;
/**
 * Created by Xingyu on 2021/5/13.
 *  TagReportlistener is used to specify the data format.
 */

public class TagReportListenerImplementation implements TagReportListener {
    String record="";
    long init=0;
    long interval=0;
    DecimalFormat df1, df2;
    Boolean flag=false;

    public TagReportListenerImplementation() {
        System.out.println("AllTagReportListener");
        df1 = new DecimalFormat("#0.0");
        df2 = new DecimalFormat("#0.00000");
    }

    public void onTagReported(ImpinjReader reader, TagReport report) {
        List<Tag> tags = report.getTags();

        for (Tag t : tags) {
            System.out.print(" EPC: " + t.getEpc().toString());
            if (t.isFastIdPresent()) {
               synchronized (this) {
                   if (!flag) {
                       init = t.getFirstSeenTime().getLocalDateTime().getTime();
                       flag = true;
                   }
               }
                interval = t.getFirstSeenTime().getLocalDateTime().getTime()-init;
                // The data format is specified below, including the following six fields:
                //  ID      Phase       RSSI(dBm)    Time(ms)    Frequency(MHz)   SensorID
                //  07      0.11045     -21.5          0         920.625          01
                record= t.getEpc().toString().replace(" ","").substring(10,12)+" "+
                        df2.format(t.getPhaseAngleInRadians())+" "+
                        df1.format(t.getPeakRssiInDbm())+" "+
                        interval+ " "+
                        t.getChannelInMhz()+" "
                        +ReadTags.SENSORID;
                ReadTags.arr.add(record+'\n');
            }
            System.out.println("");
        }
    }
}

